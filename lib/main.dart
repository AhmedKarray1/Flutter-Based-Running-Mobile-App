import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:running_app/core/providers/view_model_provider.dart';
import 'package:running_app/ui/screens/permission_screen.dart';
import 'package:running_app/ui/screens/map_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: RunningApp()));
}

class RunningApp extends ConsumerWidget {
  const RunningApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionViewModel = ref.read(permissionViewModelProvider.notifier);

    return FutureBuilder(
      future: permissionViewModel.setLocationPermission(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final permissionState = ref.watch(permissionViewModelProvider);
        return MaterialApp(
          title: 'Running Companion',
          home: permissionState.isLocationPermissionGranted ? const MapScreen() : const PermissionScreen(),
        );
      },
    );
  }
}
