import 'package:openstack/src/features/auth/data/auth_repository_provider.dart';
import 'package:openstack/src/features/auth/domain/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_changes_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<UserModel?> authStateChanges(AuthStateChangesRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}
