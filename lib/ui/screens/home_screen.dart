import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:running_app/core/providers/view_model_provider.dart';
import 'package:running_app/ui/screens/map_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationViewModel = ref.read(locationViewModelProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Running Companion')),
      body: MapScreen(),
    );
  }
}
//  screen lel permission 
// inherited widgets
