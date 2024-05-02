import 'package:fpdart/fpdart.dart';
import 'package:openstack/src/exceptions/app_exceptions.dart';
import 'package:openstack/src/features/posts/domain/post.dart';
import 'package:openstack/src/features/posts/domain/vote.dart';

typedef EitherPost = Future<Either<ExceptionPosts, PostModel>>;
typedef EitherPosts = Future<Either<ExceptionPosts, List<PostModel>>>;
typedef EitherVoid = Future<Either<ExceptionPosts, void>>;

abstract class PostsRepository {
  EitherPost fetchPost({required String postId});
  Stream<PostModel> watchPost({required String postId});

  EitherPosts fetchPosts({String? filter});
  Stream<List<PostModel>> watchPosts();
  EitherVoid votePost({
    required String postId,
    required String userId,
    required VoteType voteType,
  });
}
