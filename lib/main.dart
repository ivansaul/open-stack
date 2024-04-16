import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openstack/src/features/app.dart';
import 'package:openstack/src/services/data/auth_service_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authStore = await AuthStoreService.init();
  runApp(
    ProviderScope(
      overrides: [
        authServiceProvider.overrideWithValue(authStore),
      ],
      child: const MyApp(),
    ),
  );
}
