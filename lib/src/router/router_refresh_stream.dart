import 'package:openstack/src/features/auth/data/auth_repository_provider.dart';
import 'package:openstack/src/features/auth/domain/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_refresh_stream.g.dart';

enum AuthStatus {
  loggedIn,
  loggedOut,
}

@Riverpod(keepAlive: true)
Stream<AuthStatus> routerRefreshStream(RouterRefreshStreamRef ref) async* {
  final authRepository = ref.watch(authRepositoryProvider);

  UserModel? previousUser;

  await for (final user in authRepository.authStateChanges()) {
    if (previousUser == null && user != null) {
      yield AuthStatus.loggedIn;
    }

    if (previousUser != null && user == null) {
      yield AuthStatus.loggedOut;
    }

    previousUser = user;
  }
}
