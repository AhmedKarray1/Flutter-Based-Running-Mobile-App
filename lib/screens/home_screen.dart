import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:running_app/services/permission_service.dart';
import '../providers/location_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Running Companion')),
      body: location.when(
        data: (data) => Center(
          child: Text('Location: ${data.latitude}, ${data.longitude}'),
        ),
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Column(children: [
          Text('Error: $error'),
          ElevatedButton(onPressed: () => PermissionService().requestLocationPermission(), child: Text("permission"))
        ]),
      ),
    );
  }
}
