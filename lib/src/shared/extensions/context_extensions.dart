import 'package:flutter/material.dart';
import 'package:openstack/src/theme/app_colors_extension.dart';
import 'package:openstack/src/theme/app_text_theme_extension.dart';

extension ContextExtensions on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  Brightness get brightness => Theme.of(this).brightness;

  AppColorsExtension get colors =>
      Theme.of(this).extension<AppColorsExtension>()!;

  AppTextThemeExtension get textTheme =>
      Theme.of(this).extension<AppTextThemeExtension>()!;
}
