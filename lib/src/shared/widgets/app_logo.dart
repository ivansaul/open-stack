import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:openstack/src/constants/constants.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';

class AppLogo extends StatelessWidget {
  final double height;

  const AppLogo({
    super.key,
    this.height = 25,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = context.brightness;
    return SvgPicture.asset(
      (brightness == Brightness.light)
          ? Constants.assetsAppLogoLight
          : Constants.assetsAppLogoDark,
      height: height,
      fit: BoxFit.fitHeight,
    );
  }
}
