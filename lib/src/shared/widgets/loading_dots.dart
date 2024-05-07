import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:openstack/src/constants/constants.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';

class LoadingDots extends StatelessWidget {
  const LoadingDots({
    super.key,
    this.height = 30,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      context.brightness == Brightness.light
          ? Constants.assetsLoadingDotsLottieDark
          : Constants.assetsLoadingDotsLottieLight,
      height: height,
      fit: BoxFit.fitHeight,
    );
  }
}
