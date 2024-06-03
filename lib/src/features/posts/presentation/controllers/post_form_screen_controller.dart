import 'package:openstack/src/features/posts/data/posts_repository_provider.dart';
import 'package:openstack/src/features/posts/domain/post_entity.dart';
import 'package:openstack/src/features/posts/presentation/controllers/post_form_controller.dart';
import 'package:openstack/src/router/app_router.dart';
import 'package:openstack/src/utils/app_toast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_form_screen_controller.g.dart';

@riverpod
class PostFormScreenController extends _$PostFormScreenController {
  @override
  FutureOr<void> build() {
    // Do nothing
  }

  Future<void> cancel() async {
    final appRouter = ref.read(appRouterProvider);
    appRouter.pop();
  }

  Future<void> createPost(PostEntity? post) async {
    final form = ref.read(postFormControllerProvider(post: post));
    final postsRepository = ref.read(postsRepositoryProvider);

    state = const AsyncValue.loading();

    await Future.delayed(const Duration(seconds: 1));

    print(form.value);

    final resEither = await postsRepository.createPost(form.value);

    state = resEither.match(
      (l) => AsyncValue.error(l, StackTrace.current),
      (r) => const AsyncValue.data(null),
    );

    resEither.match(
      (l) => AppToast.showNotification(l.message),
      (r) => AppToast.showNotification('Post created successfully'),
    );
  }

  Future<void> updatePost(PostEntity post) async {
    final form = ref.read(postFormControllerProvider(post: post));
    final postsRepository = ref.read(postsRepositoryProvider);

    state = const AsyncValue.loading();

    await Future.delayed(const Duration(seconds: 1));

    final resEither = await postsRepository.updatePost(
      post: post,
      data: form.value,
    );

    state = resEither.match(
      (l) => AsyncValue.error(l, StackTrace.current),
      (r) => const AsyncValue.data(null),
    );

    resEither.match(
      (l) => AppToast.showNotification(l.message),
      (r) => AppToast.showNotification('Post updated successfully'),
    );
  }
}
