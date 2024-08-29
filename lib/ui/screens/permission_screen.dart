import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:running_app/ui/presentation/app_colors.dart';
import 'package:running_app/ui/screens/health_permission_screen.dart';
import 'package:running_app/ui/widgets/permission_widget.dart';
import '../../core/providers/view_model_provider.dart';

class LocationPermissionScreen extends ConsumerStatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  ConsumerState<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState
    extends ConsumerState<LocationPermissionScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final permissionViewModel = ref.read(permissionViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.darkGray1,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.1),
        child: PermissionWidget(
          icon: Icon(Icons.location_on,
              size: deviceWidth * 0.2, color: AppColors.limeGreen1),
          title: "Allow your location access",
          description:
              "We will need your location to give you better experience",
          handlingPermission: () async {
            await permissionViewModel.requestLocationPermission();
            final permissionState = ref.watch(permissionViewModelProvider);
            if (permissionState.locationPermissionStatus ==
                PermissionStatus.granted) {
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HealthPermissionScreen(
                          permissionViewModel: permissionViewModel)),
                );
              }
            }
          },
          popupText: 'You should allow location permission to use the App',
        ),
      ),
    );
  }
}
