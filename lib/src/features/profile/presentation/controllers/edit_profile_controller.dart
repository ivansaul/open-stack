import 'package:openstack/src/features/auth/data/auth_repository_provider.dart';
import 'package:openstack/src/features/profile/data/profile_repository_provider.dart';
import 'package:openstack/src/features/profile/presentation/providers/edit_profile_form_provider.dart';
import 'package:openstack/src/router/app_router.dart';
import 'package:openstack/src/utils/app_toast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_profile_controller.g.dart';

@riverpod
class EditProfileController extends _$EditProfileController {
  @override
  FutureOr<void> build() {
    // Do nothing
  }

  Future<void> onSubmit() async {
    final profileRepository = ref.read(profileRepositoryProvider);
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    final editProfileForm = ref.read(editProfileFormProvider);
    final appRouter = ref.read(appRouterProvider);

    state = const AsyncLoading();

    final resEither = await profileRepository.updateProfile(
      profileId: currentUser!.id,
      body: editProfileForm.value,
    );

    state = resEither.match(
      (l) => AsyncError(l, StackTrace.current),
      (r) => const AsyncData(null),
    );

    resEither.match(
      (l) => AppToast.showNotification(l.message),
      (r) {
        AppToast.showNotification('Profile updated successfully!');
        appRouter.goNamed(AppRoute.profile.name);
      },
    );
  }

  void onCancel() {
    ref.read(appRouterProvider).pop();
  }
}
