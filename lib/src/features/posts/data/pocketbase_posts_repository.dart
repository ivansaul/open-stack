import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:openstack/src/exceptions/app_exceptions.dart';
import 'package:openstack/src/features/posts/data/posts_repository.dart';
import 'package:openstack/src/features/posts/domain/bookmark_model.dart';
import 'package:openstack/src/features/posts/domain/bookmarks_info.dart';
import 'package:openstack/src/features/posts/domain/post_model.dart';
import 'package:openstack/src/features/posts/domain/post_model_pocketbase.dart';
import 'package:openstack/src/features/posts/domain/reaction_model.dart';
import 'package:openstack/src/features/posts/domain/reaction_model_pocketbase.dart';
import 'package:openstack/src/features/posts/domain/reactions_info.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketbasePostsRepository implements PostsRepository {
  final PocketBase _pb;

  PocketbasePostsRepository(this._pb);

  String? get _userId => _pb.authStore.model?.id;

  @override
  Stream<List<PostModel>> watchPosts() {
    final controller = StreamController<List<PostModel>>();
    void eventHandler() {
      fetchPosts().then((initialPostsEither) {
        initialPostsEither.match(
          (l) => controller.addError(l),
          (r) => controller.add(r),
        );
      });
    }

    // subscribe to changes
    eventHandler();
    _pb.collection('reactions').subscribe(
          '*',
          (event) => eventHandler(),
        );
    return controller.stream;
  }

  @override
  EitherPost<List<PostModel>> fetchPosts({String? filter}) async {
    try {
      final records = await _pb.collection('posts').getFullList(
            sort: '-created',
            filter: filter,
          );

      final posts = records
          .map((record) => PostModelPocketBase.fromRecordModel(record))
          .toList();

      return Right(posts);
    } catch (e) {
      if (e is ClientException) {
        return const Left(ExceptionPosts.unknownServerError);
      }
      // TODO: handle errors
      return const Left(ExceptionPosts.unknown);
    }
  }

  @override
  EitherPost<PostModel> fetchPost({required String postId}) async {
    try {
      final record = await _pb.collection('posts').getOne(
            postId,
          );

      final post = PostModelPocketBase.fromRecordModel(record);

      return Right(post);
    } catch (e) {
      if (e is ClientException) {
        return const Left(ExceptionPosts.unknownServerError);
      }
      // TODO: handle errors
      return const Left(ExceptionPosts.unknown);
    }
  }

  @override
  Stream<PostModel> watchPost({required String postId}) {
    final controller = StreamController<PostModel>();
    void eventHandler() {
      fetchPost(postId: postId).then((initialPostEither) {
        initialPostEither.match(
          (l) => controller.addError(l),
          (r) => controller.add(r),
        );
      });
    }

    // subscribe to changes
    eventHandler();
    _pb.collection('posts').subscribe(
          postId,
          (event) => eventHandler(),
        );
    return controller.stream;
  }

  @override
  EitherPost<void> addReaction({
    required String postId,
    required ReactionType reactionType,
  }) async {
    try {
      final queryResult = await _pb.collection('reactions').getFullList(
            filter: 'profile_id="$_userId" && post_id="$postId"',
          );

      final queryRecord = (queryResult.isEmpty) ? null : queryResult.first;
      final queryReactionType = queryRecord?.getStringValue('type');

      final body = <String, dynamic>{
        "post_id": postId,
        "profile_id": _userId,
        "type": reactionType.name
      };

      if (queryReactionType == null) {
        await _pb.collection('reactions').create(body: body);
        return const Right(null);
      }

      if (reactionType.name == queryReactionType) {
        await _pb.collection('reactions').delete(queryRecord!.id);
        return const Right(null);
      }

      if (reactionType.name != queryReactionType) {
        await _pb.collection('reactions').update(queryRecord!.id, body: body);
      }
      return const Right(null);
    } catch (e) {
      // TODO: handle errors
      return const Left(ExceptionPosts.unknownServerError);
    }
  }

  @override
  Stream<ReactionsInfo> watchReactionsInfo({required String postId}) {
    final controller = StreamController<ReactionsInfo>();
    void eventHandler() {
      fetchReactionsInfo(postId: postId).then((initialReactionsEither) {
        initialReactionsEither.match(
          (l) => controller.addError(l),
          (r) => controller.add(r),
        );
      });
    }

    // subscribe to changes
    eventHandler();
    _pb.collection('reactions').subscribe(
          '*',
          filter: 'post_id = "$postId"',
          (event) => eventHandler(),
        );
    return controller.stream;
  }

  @override
  EitherPost<ReactionsInfo> fetchReactionsInfo({
    required String postId,
  }) async {
    try {
      final records = await _pb.collection('reactions').getFullList(
            filter: 'post_id = "$postId"',
          );

      final reactions =
          records.map((e) => ReactionModelPocketBase.fromRecordModel(e));

      final upVotedReactions =
          reactions.where((e) => e.type == ReactionType.up);

      final userReactions =
          reactions.where((e) => e.profileId == _userId && e.postId == postId);

      final reactionsInfo = ReactionsInfo(
        numUpVotes: upVotedReactions.length,
        type: userReactions.isEmpty ? null : userReactions.first.type,
      );
      return Right(reactionsInfo);
    } catch (e) {
      // TODO: handle errors
      return const Left(ExceptionPosts.unknownServerError);
    }
  }

  @override
  EitherPost<void> addBookmark({
    required String postId,
  }) async {
    try {
      final body = <String, dynamic>{
        "profile_id": _userId,
        "post_id": postId,
      };
      await _pb.collection('bookmarks').create(body: body);
      return const Right(null);
    } catch (e) {
      return const Left(ExceptionPosts.unknown);
    }
  }

  @override
  EitherPost<void> deleteBookmark({
    required String postId,
  }) async {
    try {
      final record = await _pb.collection('bookmarks').getFirstListItem(
            'profile_id="$_userId" && post_id="$postId"',
          );
      await _pb.collection('bookmarks').delete(record.id);
      return const Right(null);
    } catch (e) {
      return const Left(ExceptionPosts.unknown);
    }
  }

  @override
  EitherPost<BookmarksInfo> fetchBookmarksInfo({
    required String postId,
  }) async {
    try {
      final records = await _pb.collection('bookmarks').getFullList(
            filter: 'post_id = "$postId"',
          );

      final bookmarks =
          records.map((e) => BookmarkModel.fromJson(e.toString()));

      final userBookmarks =
          bookmarks.where((e) => e.profileId == _userId && e.postId == postId);

      final bookmarksInfo = BookmarksInfo(
        isBookmarked: userBookmarks.isNotEmpty,
      );
      return Right(bookmarksInfo);
    } catch (e) {
      // TODO: handle errors
      return const Left(ExceptionPosts.unknownServerError);
    }
  }

  @override
  Stream<BookmarksInfo> watchBookmarksInfo({
    required String postId,
  }) {
    final controller = StreamController<BookmarksInfo>();
    void eventHandler() {
      fetchBookmarksInfo(postId: postId).then((initialBookmarksEither) {
        initialBookmarksEither.match(
          (l) => controller.addError(l),
          (r) => controller.add(r),
        );
      });
    }

    // subscribe to changes
    eventHandler();
    _pb.collection('bookmarks').subscribe(
          '*',
          filter: 'post_id = "$postId"',
          (event) => eventHandler(),
        );
    return controller.stream;
  }
}
