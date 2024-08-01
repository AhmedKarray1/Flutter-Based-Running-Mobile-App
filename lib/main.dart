import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:running_app/core/providers/view_model_provider.dart';
import 'package:running_app/ui/screens/permission_screen.dart';
import 'package:running_app/ui/screens/map_screen.dart';

void main() {
  runApp(const ProviderScope(child: RunnigApp()));
}

class RunnigApp extends ConsumerWidget {
  const RunnigApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionState = ref.watch(permissionViewModelProvider);

    return MaterialApp(
      title: 'Running Companion',
      home: permissionState.isLocationPermissionGranted ? const MapScreen() : const PermissionScreen(),
    );
  }
}
