import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:running_app/core/viewmodels/permission_view_model.dart';
import 'package:running_app/ui/presentation/app_colors.dart';
import 'package:running_app/ui/screens/welcome_screen.dart';
import 'package:running_app/ui/widgets/permission_widget.dart';

import '../../core/providers/view_model_provider.dart';

class HealthPermissionScreen extends ConsumerStatefulWidget {
  const HealthPermissionScreen({super.key, required this.permissionViewModel});

  final PermissionViewmodel permissionViewModel;

  @override
  ConsumerState<HealthPermissionScreen> createState() =>
      _HealthPermissionScreenState();
}

class _HealthPermissionScreenState
    extends ConsumerState<HealthPermissionScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.darkGray1,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.1),
        child: PermissionWidget(
            icon: Icon(Icons.health_and_safety,
                size: deviceWidth * 0.2, color: AppColors.limeGreen1),
            title: 'Allow your health data access',
            description:
                'We will need your health access to give you better experience',
            handlingPermission: () async {
              await widget.permissionViewModel
                  .requestActivityRecognitionPermission();
              final permissionState = ref.watch(permissionViewModelProvider);

              if (permissionState.healthPermissionStatus ==
                  PermissionStatus.granted) {
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()),
                  );
                }
              }
            },
            popupText: 'You should allow health permission to use the App'),
      ),
    );
  }
}
