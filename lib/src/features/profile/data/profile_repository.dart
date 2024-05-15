import 'package:fpdart/fpdart.dart';
import 'package:openstack/src/constants/typedef.dart';
import 'package:openstack/src/exceptions/app_exceptions.dart';
import 'package:openstack/src/features/auth/domain/user.dart';
import 'package:openstack/src/features/posts/domain/post_model.dart';

typedef EitherProfile<T> = Future<Either<ExceptionProfile, T>>;

abstract class ProfileRepository {
  EitherProfile<UserModel> fetchProfile(
    String profileId,
  );

  EitherProfile<UserModel> updateProfile({
    required String profileId,
    required BodyMap body,
  });

  EitherProfile<List<PostModel>> fetchMyPosts();

  EitherProfile<List<PostModel>> fetchMyUpVotedPosts();

  EitherProfile<List<PostModel>> fetchMyBookmarkedPosts();
}
