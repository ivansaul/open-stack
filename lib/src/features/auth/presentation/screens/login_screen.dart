import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:openstack/src/features/auth/presentation/controllers/login_controller.dart';
import 'package:openstack/src/features/auth/presentation/providers/login_form_group_provider.dart';
import 'package:openstack/src/features/auth/presentation/widgets/auth_filled_button.dart';
import 'package:openstack/src/features/auth/presentation/widgets/auth_social_buttons.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';
import 'package:openstack/src/shared/widgets/app_logo.dart';
import 'package:openstack/src/shared/widgets/outline_reactive_text_field.dart';
import 'package:openstack/src/theme/app_icons.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);
    final loginFormGroup = ref.watch(loginFormGroupProvider);
    return Scaffold(
      backgroundColor: context.colors.brandBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(40),
                  const AppLogo(),
                  const Gap(50),
                  Text(
                    'Log in',
                    style: context.textTheme.heading2Bold
                        .tsColor(context.colors.brandBlack),
                  ),
                  ReactiveForm(
                    formGroup: loginFormGroup,
                    child: Column(
                      children: [
                        const Gap(30),
                        OutlineReactiveTextField(
                          hintText: 'Email',
                          formControlName: AuthFormControl.email.name,
                          prefixIcon: const Icon(AppIcons.email_outlined),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const Gap(20),
                        OutlineReactiveTextField(
                          hintText: 'Password',
                          obscureText: true,
                          formControlName: AuthFormControl.password.name,
                          prefixIcon: const Icon(AppIcons.lock_outlined),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: context.textTheme.body2Medium
                                  .tsColor(context.colors.brandBlueDeep),
                            ),
                          ),
                        ),
                        const Gap(20),
                        ReactiveFormConsumer(
                          builder: (context, formGroup, child) {
                            final isValidForm = formGroup.valid;
                            return AuthFilledButton(
                              text: 'Log in',
                              loading: state.isLoading,
                              enable: isValidForm,
                              onPressed: () {
                                ref
                                    .read(loginControllerProvider.notifier)
                                    .loginWithEmailPassword();
                              },
                            );
                          },
                        ),
                        const Gap(30),
                        Text(
                          '- OR Continue with -',
                          style: context.textTheme.body2Medium,
                        ),
                        const Gap(20),
                        const AuthSocialButtons(),
                        const Gap(20),
                        const _SignUpTextButtonView()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpTextButtonView extends StatelessWidget {
  const _SignUpTextButtonView();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Not a member yet?',
          style: context.textTheme.body2Regular,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Sign Up',
            style: context.textTheme.body2Medium
                .tsColor(context.colors.brandBlack)
                .copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: context.colors.brandBlack,
                ),
          ),
        ),
      ],
    );
  }
}
