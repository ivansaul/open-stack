import 'package:fpdart/fpdart.dart';
import 'package:openstack/src/exceptions/app_exceptions.dart';
import 'package:openstack/src/features/posts/domain/post_model.dart';
import 'package:openstack/src/features/posts/domain/reaction_model.dart';
import 'package:openstack/src/features/posts/domain/reactions_info.dart';

typedef EitherPost<T> = Future<Either<ExceptionPosts, T>>;

abstract class PostsRepository {
  EitherPost<PostModel> fetchPost({
    required String postId,
  });

  Stream<PostModel> watchPost({
    required String postId,
  });

  // TODO: improve parameters
  EitherPost<List<PostModel>> fetchPosts({
    String? filter,
  });

  // TODO: improve parameters
  Stream<List<PostModel>> watchPosts();

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
}
