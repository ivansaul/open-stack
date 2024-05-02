import 'package:openstack/src/features/posts/data/posts_repository_provider.dart';
import 'package:openstack/src/features/posts/domain/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_providers.g.dart';

@riverpod
Stream<PostModel> watchPost(WatchPostRef ref, String postId) {
  final postsRepository = ref.watch(postsRepositoryProvider);
  return postsRepository.watchPost(postId: postId);
}

@Riverpod(keepAlive: false)
Stream<List<PostModel>> watchPosts(WatchPostsRef ref) {
  final postsRepository = ref.watch(postsRepositoryProvider);
  return postsRepository.watchPosts();
}
