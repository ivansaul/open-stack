import 'dart:async';

import 'package:openstack/src/features/auth/domain/user.dart';
import 'package:openstack/src/features/posts/data/posts_repository_provider.dart';
import 'package:openstack/src/features/posts/domain/bookmarks_info.dart';
import 'package:openstack/src/features/posts/domain/post_model.dart';
import 'package:openstack/src/features/posts/domain/reactions_info.dart';
import 'package:openstack/src/features/profile/data/profile_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_providers.g.dart';

@riverpod
Stream<PostModel> watchPost(WatchPostRef ref, String postId) {
  final postsRepository = ref.watch(postsRepositoryProvider);
  return postsRepository.watchPost(postId: postId);
}

@riverpod
Stream<List<PostModel>> watchPosts(WatchPostsRef ref) {
  final postsRepository = ref.watch(postsRepositoryProvider);
  return postsRepository.watchPosts();
}

// Watches the reactions information for a specific post
// identified by postId.
@riverpod
Stream<ReactionsInfo> watchPostReactionsInfo(
  WatchPostReactionsInfoRef ref,
  String postId,
) {
  final postsRepository = ref.watch(postsRepositoryProvider);
  return postsRepository.watchReactionsInfo(postId: postId);
}

// Fetches the author of the post identified by postId.
@riverpod
Future<UserModel> fetchPostAuthor(
  FetchPostAuthorRef ref,
  String authorId,
) async {
  final profileRepository = ref.watch(profileRepositoryProvider);
  final resEither = await profileRepository.fetchProfile(authorId);
  return resEither.match(
    (l) => Future.error(l),
    (r) => r,
  );
}

@riverpod
Stream<BookmarksInfo> watchPostBookmarksInfo(
  WatchPostBookmarksInfoRef ref,
  String postId,
) {
  final postRepository = ref.watch(postsRepositoryProvider);
  return postRepository.watchBookmarksInfo(postId: postId);
}
