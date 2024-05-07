import 'package:fpdart/fpdart.dart';
import 'package:openstack/src/exceptions/app_exceptions.dart';
import 'package:openstack/src/features/auth/data/auth_repository.dart';
import 'package:openstack/src/features/auth/domain/user.dart';
import 'package:openstack/src/features/auth/domain/user_pocketbase.dart';
import 'package:openstack/src/utils/in_memory_store.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketBaseAuthRepository implements AuthRepository {
  final PocketBase _pb;
  final _authState = InMemoryStore<UserModel?>(null);

  PocketBaseAuthRepository(this._pb) {
    _onAuthStateChanges();
  }

  @override
  Stream<UserModel?> authStateChanges() => _authState.stream;

  @override
  UserModel? get currentUser => _authState.value;

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

  void _onAuthStateChanges() async {
    // Initial emission
    if (_pb.authStore.isValid) {
      final authData = await _pb.collection('users').authRefresh();
      final record = authData.record;
      _authState.value =
          record == null ? null : UserPocketBase.fromRecordModel(record);
    }
    // Stream that gets triggered on [save()] and [clear()]
    _pb.authStore.onChange.listen((event) {
      if (event.model == null) {
        _authState.value = null;
      } else {
        final record = event.model as RecordModel;
        _authState.value = UserPocketBase.fromRecordModel(record);
      }
    });

    // Subscription to any current user changes
    _pb.collection('users').subscribe('*', (event) {
      final record = event.record;

      _authState.value =
          record == null ? null : UserPocketBase.fromRecordModel(record);
    });
  }
}
