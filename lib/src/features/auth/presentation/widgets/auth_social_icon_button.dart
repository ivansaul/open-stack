import 'package:flutter/material.dart';
import 'package:openstack/src/constants/constants.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';

enum SocialIcon {
  google,
  apple,
  facebook,
}

class AuthSocialIconButton extends StatelessWidget {
  final SocialIcon socialIcon;
  final void Function()? onPressed;
  const AuthSocialIconButton({
    super.key,
    required this.socialIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final icon = switch (socialIcon) {
      SocialIcon.apple => Constants.assetsAppleLogo,
      SocialIcon.google => Constants.assetsGoogleLogo,
      SocialIcon.facebook => Constants.assetsFacebookLogo,
    };

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        side: BorderSide(color: context.colors.greyGrey250, width: 2),
        minimumSize: const Size(50, 50),
      ),
      onPressed: onPressed,
      child: Image.asset(
        icon,
        color: context.colors.brandBlack,
      ),
    );
  }
}
