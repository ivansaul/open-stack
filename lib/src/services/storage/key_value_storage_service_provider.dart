import 'package:openstack/src/services/storage/key_value_storage_service.dart';
import 'package:openstack/src/services/storage/shared_preferences_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'key_value_storage_service_provider.g.dart';

@Riverpod(keepAlive: true)
KeyValueStorageService keyValueStorageService(KeyValueStorageServiceRef ref) {
  return SharedPreferencesService();
}
