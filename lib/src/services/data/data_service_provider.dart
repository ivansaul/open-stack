import 'package:openstack/src/constants/constants.dart';
import 'package:openstack/src/services/data/auth_service_provider.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_service_provider.g.dart';

@Riverpod(keepAlive: true)
PocketBase dataService(DataServiceRef ref) {
  final authService = ref.watch(authServiceProvider);
  return PocketBase(Constants.apiBaseUrl, authStore: authService);
}
