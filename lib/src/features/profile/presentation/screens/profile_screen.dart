import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openstack/src/features/auth/domain/user.dart';
import 'package:openstack/src/features/auth/presentation/providers/auth_state_changes_provider.dart';
import 'package:openstack/src/features/profile/presentation/widgets/profile_header_delegate.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/widgets/async_value_widgets.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(authStateChangesProvider);
    return ScaffoldAsyncValueWidget(
      asyncValue: currentUserAsync,
      data: (user) => _ScaffoldView(user: user),
    );
  }
}

class _ScaffoldView extends StatelessWidget {
  const _ScaffoldView({
    required this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: context.colors.brandBackground,
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: ProfileHeaderDelegate(
                    user: user,
                    tabs: const [
                      Text('Posts'),
                      Text('Upvoted'),
                      Text('Bookmarked'),
                    ],
                  ),
                ),
              ];
            },
            body: const TabBarView(
              children: [
                _PostsView(),
                Icon(Icons.directions_car, size: 350),
                Icon(Icons.directions_car, size: 350),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PostsView extends HookWidget {
  const _PostsView();

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 100,
          child: Center(child: Text('Post $index')),
        );
      },
    );
  }
}
