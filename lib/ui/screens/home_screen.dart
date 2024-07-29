import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:running_app/ui/screens/map_screen.dart';
import 'package:running_app/core/services/permission_service.dart';
import '../../core/providers/location_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Running Companion')),
      body: location.when(
        data: (data) => MapScreen(
          data: data,
        ),
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Column(children: [
          Text('Error: $error'),
          ElevatedButton(
            onPressed: () async {
              final didGivePermission = await PermissionService().requestLocationPermission();
              print(didGivePermission);
            },
            child: const Text("permission"),
          )
        ]),
      ),
    );
  }
}
//  screen lel permission 
// inherited widgets
