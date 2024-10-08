import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:running_app/core/providers/view_model_provider.dart';
import 'package:running_app/firebase_options.dart';
import 'package:running_app/ui/screens/welcome_screen.dart';
import 'package:running_app/ui/screens/health_permission_screen.dart';
import 'package:running_app/ui/screens/permission_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: RunningApp()));
}

class RunningApp extends ConsumerWidget {
  const RunningApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionViewModel = ref.read(permissionViewModelProvider.notifier);

    return FutureBuilder(
      future: permissionViewModel.getLocationPermission(),
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
          home: permissionState.locationPermissionStatus !=
                  PermissionStatus.granted
              ? const LocationPermissionScreen()
              : permissionState.healthPermissionStatus !=
                      PermissionStatus.granted
                  ? HealthPermissionScreen(
                      permissionViewModel: permissionViewModel,
                    )
                  : const WelcomeScreen(),
        );
      },
    );
  }
}
