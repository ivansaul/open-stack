import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openstack/src/router/app_router.dart';
import 'package:openstack/src/theme/app_theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Open Stack',
      builder: BotToastInit(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme(light: true).getTheme,
      darkTheme: AppTheme(light: false).getTheme,
      themeMode: ThemeMode.system,
    );
  }
}
