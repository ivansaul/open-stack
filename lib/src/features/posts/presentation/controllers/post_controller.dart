import 'package:openstack/src/features/auth/data/auth_repository_provider.dart';
import 'package:openstack/src/features/posts/data/posts_repository_provider.dart';
import 'package:openstack/src/features/posts/domain/vote.dart';
import 'package:openstack/src/router/app_router.dart';
import 'package:openstack/src/utils/app_toast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_controller.g.dart';

@riverpod
class PostController extends _$PostController {
  @override
  FutureOr<void> build() {
    // Do nothing
  }

  Future<void> onVote({
    required String postId,
    required VoteType voteType,
  }) async {
    final postsRepository = ref.read(postsRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);

    final currentUser = authRepository.currentUser;

    if (currentUser == null) return;

    state = const AsyncValue.loading();

    final resEither = await postsRepository.votePost(
      postId: postId,
      userId: currentUser.id,
      voteType: voteType,
    );

    state = resEither.match(
      (l) => AsyncValue.error(l, StackTrace.current),
      (r) => const AsyncValue.data(null),
    );

    resEither.match(
      (l) => AppToast.showNotification(l.message),
      (r) => null,
    );
  }

  void goToPostDetailScreen({required String postId}) async {
    final appRouter = ref.read(appRouterProvider);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => appRouter.pushNamed(
        AppRoute.postDetail.name,
        pathParameters: {'postId': postId},
      ),
    );
  }
}
