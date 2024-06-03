import 'package:fpdart/fpdart.dart';
import 'package:openstack/src/constants/typedef.dart';
import 'package:openstack/src/exceptions/app_exceptions.dart';
import 'package:openstack/src/features/posts/domain/bookmarks_info.dart';
import 'package:openstack/src/features/posts/domain/post_entity.dart';
import 'package:openstack/src/features/posts/domain/reaction_model.dart';
import 'package:openstack/src/features/posts/domain/reactions_info.dart';

typedef EitherPost<T> = Future<Either<ExceptionPosts, T>>;

abstract class PostsRepository {
  EitherPost<void> createPost(
    MapDynamic data,
  );

  EitherPost<void> updatePost({
    required PostEntity post,
    required MapDynamic data,
  });

  EitherPost<PostEntity> fetchPost({
    required String postId,
  });

  Future<String?> fetchFileUrl(
    String fileId,
  );

  Stream<PostEntity> watchPost({
    required String postId,
  });

  // TODO: improve parameters
  EitherPost<List<PostEntity>> fetchPosts({
    String? filter,
  });

  // TODO: improve parameters
  Stream<List<PostEntity>> watchPosts();

  EitherPost<void> addReaction({
    required String postId,
    required ReactionType reactionType,
  });

  EitherPost<ReactionsInfo> fetchReactionsInfo({
    required String postId,
  });

  Stream<ReactionsInfo> watchReactionsInfo({
    required String postId,
  });

  EitherPost<void> addBookmark({
    required String postId,
  });

  EitherPost<void> deleteBookmark({
    required String postId,
  });

  EitherPost<BookmarksInfo> fetchBookmarksInfo({
    required String postId,
  });

  Stream<BookmarksInfo> watchBookmarksInfo({
    required String postId,
  });
}
