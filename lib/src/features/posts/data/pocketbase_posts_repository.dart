import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:openstack/src/exceptions/app_exceptions.dart';
import 'package:openstack/src/features/auth/domain/user.dart';
import 'package:openstack/src/features/posts/data/posts_repository.dart';
import 'package:openstack/src/features/posts/domain/post.dart';
import 'package:openstack/src/features/posts/domain/post_pocketbase.dart';
import 'package:openstack/src/features/posts/domain/vote.dart';
import 'package:openstack/src/utils/in_memory_store.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketbasePostsRepository implements PostsRepository {
  final PocketBase _pb;
  final User? _currentUser;

  final _posts = InMemoryStore<List<PostModel>>([]);

  PocketbasePostsRepository(this._pb, this._currentUser) {
    _listenPostsChanges();
  }

  @override
  Stream<List<PostModel>> watchPosts() => _posts.stream;

  @override
  EitherPosts fetchPosts({String? filter}) async {
    try {
      final records = await _pb.collection('posts').getFullList(
            sort: '-created',
            expand: 'author, comments_via_post.user, votes_via_post.user',
            filter: filter,
          );

      final posts = records
          .map((record) =>
              PostPocketBase.fromRecordModel(record, _currentUser?.id))
          .toList();

      return Right(posts);
    } catch (e) {
      if (e is ClientException) {
        return const Left(ExceptionPosts.unknownServerError);
      }
      return const Left(ExceptionPosts.unknown);
    }
  }

  @override
  EitherPost fetchPost({required String postId}) async {
    try {
      final record = await _pb.collection('posts').getOne(
            postId,
            expand: 'author, comments_via_post.user, votes_via_post.user',
          );

      final post = PostPocketBase.fromRecordModel(record, _currentUser?.id);

      return Right(post);
    } catch (e) {
      if (e is ClientException) {
        return const Left(ExceptionPosts.unknownServerError);
      }
      return const Left(ExceptionPosts.unknown);
    }
  }

  @override
  Stream<PostModel> watchPost({required String postId}) {
    final controller = StreamController<PostModel>();
    fetchPost(postId: postId).then((initialPostEither) {
      initialPostEither.match(
        (l) => controller.addError(l),
        (r) => controller.add(r),
      );
    });

    _pb.collection('posts').subscribe(
      postId,
      (event) async {
        final record = event.record;

        if (record == null) return;

        fetchPost(postId: postId).then((initialPostEither) {
          initialPostEither.match(
            (l) => controller.addError(l),
            (r) => controller.add(r),
          );
        });
      },
    );

    _pb.collection('votes').subscribe(
      '*',
      filter: 'post = "$postId" && user = "${_currentUser?.id}"',
      (event) async {
        final record = event.record;

        if (record == null) return;

        fetchPost(postId: postId).then((initialPostEither) {
          initialPostEither.match(
            (l) => controller.addError(l),
            (r) => controller.add(r),
          );
        });
      },
    );
    return controller.stream;
  }

  @override
  EitherVoid votePost({
    required String postId,
    required String userId,
    required VoteType voteType,
  }) async {
    // TODO: implement error handling

    try {
      final queryResult = await _pb.collection('votes').getFullList(
            filter: 'user="$userId" && post="$postId"',
          );

      final queryRecord = (queryResult.isEmpty) ? null : queryResult.first;
      final currentVoteType = queryRecord?.getStringValue('type');

      final body = <String, dynamic>{
        "post": postId,
        "user": userId,
        "type": voteType.name
      };

      if (currentVoteType == null) {
        await _pb.collection('votes').create(body: body);
        return const Right(null);
      }

      if (voteType.name == currentVoteType) {
        await _pb.collection('votes').delete(queryRecord!.id);
        return const Right(null);
      }

      if (voteType.name != currentVoteType) {
        await _pb.collection('votes').update(queryRecord!.id, body: body);
      }
      return const Right(null);
    } catch (e) {
      return const Left(ExceptionPosts.unknownServerError);
    }
  }

  void _listenPostsChanges() async {
    final initialPostsEither = await fetchPosts();
    final initialPosts = initialPostsEither.match(
      (l) => <PostModel>[],
      (r) => r,
    );

    _posts.value = initialPosts;

    _pb.collection('posts').subscribe(
      '*',
      expand: "author, comments_via_post.user, votes_via_post",
      filter: _filters.posts,
      (event) async {
        print("[posts] ${event.action}");
        // print(event.record);
        final updatedPostsEither = await fetchPosts(filter: _filters.posts);
        final updatedPosts = updatedPostsEither.match(
          (l) => <PostModel>[],
          (r) => r,
        );
        _posts.value = updatedPosts;
      },
    );

    _pb.collection('votes').subscribe('*', filter: _filters.votes,
        (event) async {
      print("[votes] ${event.action}");
      final updatedPostsEither = await fetchPosts(filter: _filters.posts);
      final updatedPosts = updatedPostsEither.match(
        (l) => <PostModel>[],
        (r) => r,
      );
      _posts.value = updatedPosts;
    });
  }

  ({String posts, String votes}) get _filters => (
        posts: _posts.value.map((post) => 'id = "${post.id}"').join(' || '),
        votes: _posts.value.map((post) => 'post = "${post.id}"').join(' || '),
      );
}
