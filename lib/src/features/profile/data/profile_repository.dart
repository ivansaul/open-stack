import 'package:fpdart/fpdart.dart';
import 'package:openstack/src/constants/typedef.dart';
import 'package:openstack/src/exceptions/app_exceptions.dart';
import 'package:openstack/src/features/auth/domain/user.dart';

typedef EitherProfile = Future<Either<ExceptionProfile, UserModel>>;

abstract class ProfileRepository {
  EitherProfile fetchProfile(String profileId);
  EitherProfile updateProfile({
    required String profileId,
    required BodyMap body,
  });
}
