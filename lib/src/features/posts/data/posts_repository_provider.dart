import 'package:openstack/src/features/posts/data/pocketbase_posts_repository.dart';
import 'package:openstack/src/features/posts/data/posts_repository.dart';
import 'package:openstack/src/services/data/data_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_repository_provider.g.dart';

@riverpod
PostsRepository postsRepository(PostsRepositoryRef ref) {
  final dataService = ref.watch(dataServiceProvider);
  return PocketbasePostsRepository(dataService);
}
