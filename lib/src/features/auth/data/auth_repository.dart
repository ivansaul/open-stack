import 'package:fpdart/fpdart.dart';
import 'package:openstack/src/exceptions/app_exceptions.dart';
import 'package:openstack/src/features/auth/domain/user.dart';

typedef AuthEither = Future<Either<AuthException, void>>;

abstract class AuthRepository {
  UserModel? get currentUser;
  Stream<UserModel?> authStateChanges();
  AuthEither loginWithEmailPassword(String email, String password);
  AuthEither logout();
}
