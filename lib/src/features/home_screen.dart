import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openstack/src/features/auth/data/auth_repository_provider.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authRepositoryProvider).currentUser;
    return Scaffold(
      backgroundColor: context.colors.brandBackground,
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Text(
          currentUser?.username ?? 'null',
          style: context.textTheme.heading2Bold,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(authRepositoryProvider).logout();
        },
        tooltip: 'Logout',
        child: const Icon(Icons.logout),
      ),
    );
  }
}
