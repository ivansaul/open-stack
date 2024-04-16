import 'package:fpdart/fpdart.dart';
import 'package:openstack/src/exceptions/app_exceptions.dart';
import 'package:openstack/src/features/auth/data/auth_repository.dart';
import 'package:openstack/src/features/auth/domain/user.dart';
import 'package:openstack/src/utils/in_memory_store.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketBaseAuthRepository implements AuthRepository {
  final PocketBase _pb;
  final _authState = InMemoryStore<User?>(null);

  PocketBaseAuthRepository(this._pb) {
    _onAuthStateChange();
  }

  @override
  Stream<User?> authStateChanges() => _authState.stream;

  @override
  User? get currentUser => _authState.value;

  @override
  AuthEither loginWithEmailPassword(String email, String password) async {
    try {
      await _pb.collection('users').authWithPassword(email, password);
      return const Right(null);
    } catch (e) {
      if (e is ClientException) {
        final errorCode = e.response['code'];
        if (errorCode == 400) {
          return const Left(AuthException.wrongEmailPassword);
        }
        return const Left(AuthException.unknownServerError);
      }
      return const Left(AuthException.unknown);
    }
  }

  @override
  AuthEither logout() async {
    _pb.authStore.clear();
    _authState.value = null;
    return const Right(null);
  }

  void _onAuthStateChange() {
    // Initial emission
    if (_pb.authStore.isValid) {
      final model = _pb.authStore.model as RecordModel;
      _authState.value = User.fromJson(model.toJson());
    }
    // Stream that gets triggered on [save()] and [clear()]
    _pb.authStore.onChange.listen((event) {
      if (event.model == null) {
        _authState.value = null;
      } else {
        final model = event.model as RecordModel;
        _authState.value = User.fromJson(model.toJson());
      }
    });
  }
}
