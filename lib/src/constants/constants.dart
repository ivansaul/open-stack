import 'package:openstack/src/env/env.dart';

class Constants {
  Constants._();

  // ASSETS
  static const String assetsAppLogoLight = 'assets/images/app_logo_light.svg';
  static const String assetsAppLogoDark = 'assets/images/app_logo_dark.svg';
  static const String assetsAppleLogo = 'assets/images/apple_logo.png';
  static const String assetsGoogleLogo = 'assets/images/google_logo.png';
  static const String assetsFacebookLogo = 'assets/images/facebook_logo.png';

  // API
  static String apiBaseUrl = Env.apiBaseUrl;

  // KEY STORAGE
  static const String keyAuthStore = 'pocketbase_auth';
}
