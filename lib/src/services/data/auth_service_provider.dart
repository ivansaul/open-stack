import 'package:openstack/src/constants/constants.dart';
import 'package:openstack/src/services/storage/shared_preferences_service.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service_provider.g.dart';

class AuthStoreService {
  static Future<AsyncAuthStore> init() async {
    const authStoreKey = Constants.keyAuthStore;
    // TODO: [Shared Preferences] wrap with a service locator
    final pref = SharedPreferencesService();

    return AsyncAuthStore(
      save: (String data) async => pref.setKeyValue<String>(authStoreKey, data),
      initial: await pref.getValue<String>(authStoreKey),
      clear: () async => pref.removeKey(authStoreKey),
    );
  }
}

@Riverpod(keepAlive: true)
AsyncAuthStore authService(AuthServiceRef ref) {
  throw UnimplementedError();
}
