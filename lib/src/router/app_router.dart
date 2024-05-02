import 'package:bot_toast/bot_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:openstack/src/features/auth/data/auth_repository_provider.dart';
import 'package:openstack/src/features/auth/presentation/providers/auth_state_changes_provider.dart';
import 'package:openstack/src/features/auth/presentation/screens/login_screen.dart';
import 'package:openstack/src/features/posts/presentation/screens/home_screen.dart';
import 'package:openstack/src/features/posts/presentation/screens/post_detail_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute {
  home('/'),
  login('/login'),
  postDetail('/post-detail');

  final String path;
  const AppRoute(this.path);
}

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  final _ = ref.watch(authStateChangesProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  final currentUser = authRepository.currentUser;

  return GoRouter(
    initialLocation: AppRoute.login.path,
    observers: [BotToastNavigatorObserver()],
    routes: [
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '${AppRoute.postDetail.path}:postId',
        name: AppRoute.postDetail.name,
        builder: (context, state) {
          final postId = state.pathParameters['postId']!;
          return PostDetailScreen(postId: postId);
        },
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = currentUser != null;
      final isGoingTo = state.fullPath;

      if (!isLoggedIn) {
        if (isGoingTo == AppRoute.login.path) return null;
      }

      if (isGoingTo == AppRoute.login.path) return AppRoute.home.path;

      return null;
    },
  );
}
