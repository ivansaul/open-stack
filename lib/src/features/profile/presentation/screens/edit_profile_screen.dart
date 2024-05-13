import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:openstack/src/features/auth/data/auth_repository_provider.dart';
import 'package:openstack/src/features/profile/presentation/controllers/edit_profile_controller.dart';
import 'package:openstack/src/features/profile/presentation/providers/edit_profile_form_provider.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';
import 'package:openstack/src/shared/widgets/filled_button_decorated.dart';
import 'package:openstack/src/shared/widgets/outline_reactive_text_field.dart';
import 'package:openstack/src/theme/app_icons.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authRepositoryProvider).currentUser;
    final formState = ref.watch(editProfileFormProvider);
    final controller = ref.watch(editProfileControllerProvider);
    final isLoading = controller.isLoading;
    return Scaffold(
      body: GestureDetector(
        onTap: () => ref.read(editProfileFormProvider.notifier).unfocus(),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: Row(
                children: [
                  FilledButtonDecorated(
                    title: 'Cancel',
                    color: Colors.transparent,
                    style: context.textTheme.body1Bold
                        .tsColor(context.colors.brandBlueDeep),
                    onPressed: () => ref
                        .read(editProfileControllerProvider.notifier)
                        .onCancel(),
                  ),
                  const Spacer(),
                  if (formState.isDirty && formState.isValid)
                    FilledButtonDecorated(
                      title: 'Submit',
                      color: context.colors.brandBlack,
                      isLoading: controller.isLoading,
                      onPressed: isLoading
                          ? null
                          : () {
                              ref
                                  .read(editProfileControllerProvider.notifier)
                                  .onSubmit();
                            },
                    ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Profile',
                    style: context.textTheme.heading3Bold,
                  ),
                  const Gap(10),
                  Text(
                    'Profile Picture',
                    style: context.textTheme.heading3Bold,
                  ),
                  Text(
                    'Upload a picture to make your profile stand out and let people recognize your comments and contributions easily!',
                    style: context.textTheme.body2Regular,
                  ),
                  const Gap(20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      currentUser?.avatar ?? '',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Gap(20),
                  Text(
                    'Account Information',
                    style: context.textTheme.heading3Bold,
                  ),
                  const Gap(10),
                  ReactiveForm(
                    formGroup: formState.formGroup,
                    child: Column(
                      children: [
                        OutlineReactiveTextField(
                          hintText: 'Name',
                          prefixIcon: const Icon(AppIcons.user_outlined),
                          formControlName: EditProfileFormControl.name.key,
                        ),
                        const Gap(10),
                        OutlineReactiveTextField(
                          hintText: 'Username',
                          prefixIcon: const Icon(Icons.alternate_email_rounded),
                          formControlName: EditProfileFormControl.username.key,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
