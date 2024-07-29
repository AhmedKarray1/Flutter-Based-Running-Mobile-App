import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:running_app/core/providers/permission_provider.dart';
import 'ui/screens/permission_screen.dart';

void main() {
  runApp(const ProviderScope(child: RunnigApp()));
}

class RunnigApp extends ConsumerWidget {
  const RunnigApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final locationPermission = ref.watch(locationPermissionStatusProvider);

    return const MaterialApp(
      title: 'Running Companion',
      home: PermissionScreen(),
    );
  }
}
