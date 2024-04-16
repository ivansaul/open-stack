import 'package:flutter/material.dart';
import 'package:openstack/src/features/auth/presentation/widgets/auth_social_icon_button.dart';

class AuthSocialButtons extends StatelessWidget {
  const AuthSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AuthSocialIconButton(
          socialIcon: SocialIcon.google,
          onPressed: () {},
        ),
        AuthSocialIconButton(
          socialIcon: SocialIcon.apple,
          onPressed: () {},
        ),
        AuthSocialIconButton(
          socialIcon: SocialIcon.facebook,
          onPressed: () {},
        ),
      ],
    );
  }
}
