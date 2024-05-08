import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';
import 'package:openstack/src/theme/app_colors_extension.dart';
import 'package:openstack/src/theme/app_text_theme_extension.dart';

class AppTheme {
  final bool light;

  AppTheme({
    required this.light,
  });

  ///
  /// Colors
  ///

  AppColorsExtension get _appColors {
    return AppColorsExtension(
      brandBlack: light ? const Color(0xff0E1217) : const Color(0xffFFFFFF),
      brandWhite: light ? const Color(0xffFFFFFF) : const Color(0xff0E1217),
      brandBlueDeep: light ? const Color(0xff525866) : const Color(0xffA8B3CF),
      brandBackground:
          light ? const Color(0xffFFFFFF) : const Color(0xff0E1217),
      greyGrey50: light ? const Color(0xffF4F5FD) : const Color(0xff282828),
      greyGrey100: light ? const Color(0xffF1F2F3) : const Color(0xff252A32),
      greyGrey150: light ? const Color(0xffF1F2F3) : const Color(0xff1A1C28),
      greyGrey200: light ? const Color(0xffD9D9D9) : const Color(0xff2C323C),
      greyGrey250: light ? const Color(0xffDCDDE0) : const Color(0xff363C47),
      generalGreen: light ? const Color(0xff15CE5C) : const Color(0xff39E58C),
      generalRed: light ? const Color(0xffC72017) : const Color(0xffE04337),
      generalOrange: light ? const Color(0xffFA6620) : const Color(0xffFF8E3B),
    );
  }

  ///
  /// Text Theme
  ///

  TextStyle _heading(int n) => TextStyle(
        color: _appColors.brandBlack,
        fontSize: switch (n) {
          1 => 32,
          2 => 24,
          3 => 18,
          _ => 18,
        },
      );
  TextStyle _button(int n) => TextStyle(
        color: _appColors.brandBlack,
        fontSize: switch (n) {
          1 => 16,
          2 => 14,
          _ => 14,
        },
      );

  TextStyle _body(Body body) => TextStyle(
        color: _appColors.brandBlueDeep,
        fontSize: switch (body) {
          Body.b1 => 16,
          Body.b2 => 14,
          Body.bC => 12,
          Body.bO => 10,
        },
      );

  AppTextThemeExtension get _textTheme {
    return AppTextThemeExtension(
      heading1Bold: _heading(1).tsBold(),
      heading2Bold: _heading(2).tsBold(),
      heading3Bold: _heading(3).tsBold(),
      heading3SemiBold: _heading(3).tsSemibold(),
      heading3Medium: _heading(3).tsMedium(),
      button1SemiBold: _button(1).tsSemibold(),
      button2SemiBold: _button(2).tsSemibold(),
      body1Bold: _body(Body.b1).tsBold(),
      body1Semibold: _body(Body.b1).tsSemibold(),
      body1Medium: _body(Body.b1).tsMedium(),
      body1Regular: _body(Body.b1).tsRegular(),
      body2Semibold: _body(Body.b2).tsSemibold(),
      body2Medium: _body(Body.b2).tsMedium(),
      body2Regular: _body(Body.b2).tsRegular(),
      bodyCaptionSemiBold: _body(Body.bC).tsSemibold(),
      bodyCaptionRegular: _body(Body.bC).tsRegular(),
      bodyOverlineSemiBold: _body(Body.bO).tsSemibold(),
      bodyOverlineRegular: _body(Body.bO).tsRegular(),
    );
  }

  ThemeData get getTheme {
    return ThemeData(
      fontFamily: GoogleFonts.roboto().fontFamily,
    ).copyWith(
      colorScheme: light ? const ColorScheme.light() : const ColorScheme.dark(),
      iconTheme: IconThemeData(
        color: _appColors.brandBlueDeep,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          // iconSize: const MaterialStatePropertyAll(20), // TODO: improve
          iconColor: MaterialStatePropertyAll(
            _appColors.brandBlueDeep,
          ),
        ),
      ),
      scaffoldBackgroundColor: _appColors.brandBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: _appColors.brandBackground,
        scrolledUnderElevation: 0,
      ),
      dividerTheme: DividerThemeData(
        color: _appColors.brandBlueDeep,
      ),
      extensions: [
        _appColors,
        _textTheme,
      ],
    );
  }
}

enum Body {
  b1,
  b2,
  bC,
  bO,
}
