import 'package:fpdart/fpdart.dart';
import 'package:openstack/src/constants/typedef.dart';
import 'package:openstack/src/exceptions/app_exceptions.dart';
import 'package:openstack/src/features/auth/domain/user.dart';

typedef EitherProfile = Future<Either<ExceptionProfile, UserModel>>;

abstract class ProfileRepository {
  EitherProfile fetchProfile(UserId userId);
  EitherProfile updateProfile({
    required UserId userId,
    required BodyMap body,
  });
}
