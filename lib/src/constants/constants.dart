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
  static const String assetsDefaultAvatar =
      'http://127.0.0.1:8090/api/files/q4ttsvalaj17co3/rciohjl2g259r6p/default_avatar_Is1Tj2H2WM.png';
  static const String assetsDefaultProfileCover =
      'http://127.0.0.1:8090/api/files/q4ttsvalaj17co3/4xyhbg2zt2cl19u/open_stack_cover_xDSoIGlaDR.webp';
  static const String assetsDefaultThumbnail =
      'http://127.0.0.1:8090/api/files/q4ttsvalaj17co3/uxkshazazr7ag22/placeholder1_4GsP7e2zVH.webp';

  // API
  static String apiBaseUrl = Env.apiBaseUrl;

  // KEY STORAGE
  static const String keyAuthStore = 'pocketbase_auth';

  // PATTERNS

  // This pattern was taken from GetX package
  // https://github.com/jonataslaw/getx/blob/master/lib/get_utils/src/get_utils/get_utils.dart
  static const String patternsUrl =
      r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,7}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$";
}
