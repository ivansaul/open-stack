import 'package:openstack/src/features/profile/data/pocketbase_profile_repository.dart';
import 'package:openstack/src/features/profile/data/profile_repository.dart';
import 'package:openstack/src/services/data/data_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository_provider.g.dart';

@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  final dataService = ref.watch(dataServiceProvider);
  return PocketBaseProfileRepository(dataService);
}
