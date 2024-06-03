import 'package:openstack/src/features/posts/domain/post_entity.dart';
import 'package:openstack/src/features/profile/data/profile_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_posts_providers.g.dart';

@riverpod
Future<List<PostEntity>> fetchMyPosts(FetchMyPostsRef ref) async {
  final profileRepository = ref.watch(profileRepositoryProvider);
  final resEither = await profileRepository.fetchMyPosts();
  return resEither.match(
    (l) => Future.error(l),
    (r) => r,
  );
}

@riverpod
Future<List<PostEntity>> fetchMyUpVotedPosts(
  FetchMyUpVotedPostsRef ref,
) async {
  final profileRepository = ref.watch(profileRepositoryProvider);
  final resEither = await profileRepository.fetchMyUpVotedPosts();
  return resEither.match(
    (l) => Future.error(l),
    (r) => r,
  );
}

@riverpod
Future<List<PostEntity>> fetchMyBookmarkedPosts(
  FetchMyBookmarkedPostsRef ref,
) async {
  final profileRepository = ref.watch(profileRepositoryProvider);
  final resEither = await profileRepository.fetchMyBookmarkedPosts();
  return resEither.match(
    (l) => Future.error(l),
    (r) => r,
  );
}
