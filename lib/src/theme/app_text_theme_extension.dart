// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class AppTextThemeExtension extends ThemeExtension<AppTextThemeExtension> {
  final TextStyle heading1Bold;
  final TextStyle heading2Bold;
  final TextStyle heading3Bold;

  final TextStyle button1SemiBold;
  final TextStyle button2SemiBold;

  final TextStyle body1Medium;
  final TextStyle body1Regular;
  final TextStyle body2Medium;
  final TextStyle body2Regular;
  final TextStyle bodyCaptionSemiBold;
  final TextStyle bodyCaptionRegular;
  final TextStyle bodyOverlineSemiBold;
  final TextStyle bodyOverlineRegular;

  const AppTextThemeExtension({
    required this.heading1Bold,
    required this.heading2Bold,
    required this.heading3Bold,
    required this.button1SemiBold,
    required this.button2SemiBold,
    required this.body1Medium,
    required this.body1Regular,
    required this.body2Medium,
    required this.body2Regular,
    required this.bodyCaptionSemiBold,
    required this.bodyCaptionRegular,
    required this.bodyOverlineSemiBold,
    required this.bodyOverlineRegular,
  });

  @override
  ThemeExtension<AppTextThemeExtension> lerp(
    covariant ThemeExtension<AppTextThemeExtension>? other,
    double t,
  ) {
    if (other is! AppTextThemeExtension) return this;

    return AppTextThemeExtension(
      heading1Bold: TextStyle.lerp(heading1Bold, other.heading1Bold, t)!,
      heading2Bold: TextStyle.lerp(heading2Bold, other.heading2Bold, t)!,
      heading3Bold: TextStyle.lerp(heading3Bold, other.heading3Bold, t)!,
      button1SemiBold:
          TextStyle.lerp(button1SemiBold, other.button1SemiBold, t)!,
      button2SemiBold:
          TextStyle.lerp(button2SemiBold, other.button2SemiBold, t)!,
      body1Medium: TextStyle.lerp(body1Medium, other.body1Medium, t)!,
      body1Regular: TextStyle.lerp(body1Regular, other.body1Regular, t)!,
      body2Medium: TextStyle.lerp(body2Medium, other.body2Medium, t)!,
      body2Regular: TextStyle.lerp(body2Regular, other.body2Regular, t)!,
      bodyCaptionSemiBold:
          TextStyle.lerp(bodyCaptionSemiBold, other.bodyCaptionSemiBold, t)!,
      bodyCaptionRegular:
          TextStyle.lerp(bodyCaptionRegular, other.bodyCaptionRegular, t)!,
      bodyOverlineSemiBold:
          TextStyle.lerp(bodyOverlineSemiBold, other.bodyOverlineSemiBold, t)!,
      bodyOverlineRegular:
          TextStyle.lerp(bodyOverlineRegular, other.bodyOverlineRegular, t)!,
    );
  }

  @override
  AppTextThemeExtension copyWith({
    TextStyle? heading1Bold,
    TextStyle? heading2Bold,
    TextStyle? heading3Bold,
    TextStyle? button1SemiBold,
    TextStyle? button2SemiBold,
    TextStyle? body1Medium,
    TextStyle? body1Regular,
    TextStyle? body2Medium,
    TextStyle? body2Regular,
    TextStyle? bodyCaptionSemiBold,
    TextStyle? bodyCaptionRegular,
    TextStyle? bodyOverlineSemiBold,
    TextStyle? bodyOverlineRegular,
  }) {
    return AppTextThemeExtension(
      heading1Bold: heading1Bold ?? this.heading1Bold,
      heading2Bold: heading2Bold ?? this.heading2Bold,
      heading3Bold: heading3Bold ?? this.heading3Bold,
      button1SemiBold: button1SemiBold ?? this.button1SemiBold,
      button2SemiBold: button2SemiBold ?? this.button2SemiBold,
      body1Medium: body1Medium ?? this.body1Medium,
      body1Regular: body1Regular ?? this.body1Regular,
      body2Medium: body2Medium ?? this.body2Medium,
      body2Regular: body2Regular ?? this.body2Regular,
      bodyCaptionSemiBold: bodyCaptionSemiBold ?? this.bodyCaptionSemiBold,
      bodyCaptionRegular: bodyCaptionRegular ?? this.bodyCaptionRegular,
      bodyOverlineSemiBold: bodyOverlineSemiBold ?? this.bodyOverlineSemiBold,
      bodyOverlineRegular: bodyOverlineRegular ?? this.bodyOverlineRegular,
    );
  }
}
