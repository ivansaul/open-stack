import 'package:openstack/src/features/auth/data/auth_repository.dart';
import 'package:openstack/src/features/auth/data/pocketbase_auth_repository.dart';
import 'package:openstack/src/services/data/data_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final dataService = ref.watch(dataServiceProvider);
  return PocketBaseAuthRepository(dataService);
}
