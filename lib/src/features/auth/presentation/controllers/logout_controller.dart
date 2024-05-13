import 'package:openstack/src/features/auth/data/auth_repository_provider.dart';
import 'package:openstack/src/utils/app_toast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_controller.g.dart';

@riverpod
class LogoutController extends _$LogoutController {
  @override
  FutureOr<void> build() {
    // Do nothing
  }

  void logout() async {
    final authRepository = ref.read(authRepositoryProvider);

    state = const AsyncValue.loading();

    final resEither = await authRepository.logout();

    state = resEither.match(
      (error) => AsyncError(error, StackTrace.current),
      (data) => AsyncData(data),
    );

    resEither.match(
      (error) => AppToast.showNotification(error.message),
      (data) => AppToast.closeAllToasts(),
    );
  }
}
