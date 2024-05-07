import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openstack/src/features/auth/data/auth_repository_provider.dart';
import 'package:openstack/src/features/auth/presentation/screens/login_screen.dart';
import 'package:openstack/src/features/posts/presentation/screens/home_screen.dart';
import 'package:openstack/src/features/posts/presentation/screens/post_detail_screen.dart';
import 'package:openstack/src/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:openstack/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:openstack/src/features/settings/screens/settings_screen.dart';
import 'package:openstack/src/router/router_refresh_stream.dart';
import 'package:openstack/src/shared/widgets/scaffold_with_nested_navigation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute {
  home('/'),
  login('/login'),
  postDetail('/post-detail'),
  profile('/profile'),
  settings('/settings'),
  editProfile('edit-profile'),
  ;

  final String path;
  const AppRoute(this.path);
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'profile');

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  final _ = ref.watch(routerRefreshStreamProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  final currentUser = authRepository.currentUser;

  return GoRouter(
    debugLogDiagnostics: false,
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoute.home.path,
    observers: [BotToastNavigatorObserver()],
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: AppRoute.home.path,
                name: AppRoute.home.name,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: AppRoute.profile.path,
                name: AppRoute.profile.name,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          )
        ],
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
      GoRoute(
        path: AppRoute.settings.path,
        name: AppRoute.settings.name,
        builder: (context, state) => const SettingsScreen(),
        routes: [
          GoRoute(
            path: AppRoute.editProfile.path,
            name: AppRoute.editProfile.name,
            builder: (context, state) => const EditProfileScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = currentUser != null;
      final isGoingTo = state.fullPath;

      if (!isLoggedIn) {
        if (isGoingTo == AppRoute.login.path) return null;
        return AppRoute.login.path;
      }

      if (isGoingTo == AppRoute.login.path) return AppRoute.home.path;

      return null;
    },
  );
}
