import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_BASE_URL', obfuscate: true)
  static String apiBaseUrl = _Env.apiBaseUrl;
}
