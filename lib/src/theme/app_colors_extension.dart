// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color brandBlack;
  final Color brandWhite;
  final Color brandBlueDeep;
  final Color brandBackground;

  final Color greyGrey50;
  final Color greyGrey100;
  final Color greyGrey150;
  final Color greyGrey200;
  final Color greyGrey250;

  final Color generalGreen;
  final Color generalRed;
  final Color generalOrange;

  const AppColorsExtension({
    required this.brandBlack,
    required this.brandWhite,
    required this.brandBlueDeep,
    required this.brandBackground,
    required this.greyGrey50,
    required this.greyGrey100,
    required this.greyGrey150,
    required this.greyGrey200,
    required this.greyGrey250,
    required this.generalGreen,
    required this.generalRed,
    required this.generalOrange,
  });

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) return this;

    return AppColorsExtension(
      brandBlack: Color.lerp(brandBlack, other.brandBlack, t)!,
      brandWhite: Color.lerp(brandWhite, other.brandWhite, t)!,
      brandBlueDeep: Color.lerp(brandBlueDeep, other.brandBlueDeep, t)!,
      brandBackground: Color.lerp(brandBackground, other.brandBackground, t)!,
      greyGrey50: Color.lerp(greyGrey50, other.greyGrey50, t)!,
      greyGrey100: Color.lerp(greyGrey100, other.greyGrey100, t)!,
      greyGrey150: Color.lerp(greyGrey150, other.greyGrey150, t)!,
      greyGrey200: Color.lerp(greyGrey200, other.greyGrey200, t)!,
      greyGrey250: Color.lerp(greyGrey250, other.greyGrey250, t)!,
      generalGreen: Color.lerp(generalGreen, other.generalGreen, t)!,
      generalRed: Color.lerp(generalRed, other.generalRed, t)!,
      generalOrange: Color.lerp(generalOrange, other.generalOrange, t)!,
    );
  }

  @override
  AppColorsExtension copyWith({
    Color? brandBlack,
    Color? brandWhite,
    Color? brandBlueDeep,
    Color? brandBackground,
    Color? greyGrey50,
    Color? greyGrey100,
    Color? greyGrey150,
    Color? greyGrey200,
    Color? greyGrey250,
    Color? generalGreen,
    Color? generalRed,
    Color? generalOrange,
  }) {
    return AppColorsExtension(
      brandBlack: brandBlack ?? this.brandBlack,
      brandWhite: brandWhite ?? this.brandWhite,
      brandBlueDeep: brandBlueDeep ?? this.brandBlueDeep,
      brandBackground: brandBackground ?? this.brandBackground,
      greyGrey50: greyGrey50 ?? this.greyGrey50,
      greyGrey100: greyGrey100 ?? this.greyGrey100,
      greyGrey150: greyGrey150 ?? this.greyGrey150,
      greyGrey200: greyGrey200 ?? this.greyGrey200,
      greyGrey250: greyGrey250 ?? this.greyGrey250,
      generalGreen: generalGreen ?? this.generalGreen,
      generalRed: generalRed ?? this.generalRed,
      generalOrange: generalOrange ?? this.generalOrange,
    );
  }
}
