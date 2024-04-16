import 'package:openstack/src/features/auth/data/auth_repository_provider.dart';
import 'package:openstack/src/features/auth/domain/login_form.dart';
import 'package:openstack/src/features/auth/presentation/providers/login_form_group_provider.dart';
import 'package:openstack/src/utils/app_toast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@Riverpod(keepAlive: true)
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {
    // Do nothing
  }

  void loginWithEmailPassword() async {
    final authRepository = ref.read(authRepositoryProvider);
    final loginFormGroup = ref.read(loginFormGroupProvider);
    final form = LoginForm.fromJson(loginFormGroup.value);

    state = const AsyncValue.loading();

    final resEither = await authRepository.loginWithEmailPassword(
      form.email,
      form.password,
    );

    state = resEither.match(
      (error) => AsyncError(error, StackTrace.current),
      (data) => AsyncData(data),
    );

    resEither.match(
      (error) => AppToast.showNotification(error.message),
      (data) => AppToast.closeAllToasts(),
    );
  }

  void logout() async {
    final authRepository = ref.read(authRepositoryProvider);
    final resEither = await authRepository.logout();

    state = const AsyncValue.loading();
    state = resEither.match(
      (error) => AsyncError(error, StackTrace.current),
      (data) => AsyncData(data),
    );
  }
}
