import 'package:openstack/src/env/env.dart';

class Constants {
  Constants._();

  // ASSETS
  static const String assetsAppLogoLight = 'assets/images/app_logo_light.svg';
  static const String assetsAppLogoDark = 'assets/images/app_logo_dark.svg';
  static const String assetsAppleLogo = 'assets/images/apple_logo.png';
  static const String assetsGoogleLogo = 'assets/images/google_logo.png';
  static const String assetsFacebookLogo = 'assets/images/facebook_logo.png';
  static const String assetsLoadingDotsLottieLight =
      'assets/lotties/dots_loading_light.json';
  static const String assetsLoadingDotsLottieDark =
      'assets/lotties/dots_loading_dark.json';
  static const String assetsDefaultAvatar = 'https://i.imgur.com/OozHpeP.png';
  static const String assetsDefaultProfileCover =
      'https://i.imgur.com/dzyie6N.png';
  // API
  static String apiBaseUrl = Env.apiBaseUrl;

  // KEY STORAGE
  static const String keyAuthStore = 'pocketbase_auth';
}
