import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:running_app/ui/presentation/app_colors.dart';
import '../../core/providers/view_model_provider.dart';

class PermissionScreen extends ConsumerStatefulWidget {
  const PermissionScreen({super.key});

  @override
  ConsumerState<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends ConsumerState<PermissionScreen> {
  bool _showLocationPermission = true;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final permissionViewModel = ref.read(permissionViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.darkGray1,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.1),
        child: AnimatedCrossFade(
          firstChild: _buildPermissionWidget(
            context,
            "Allow your location",
            "We will need your location to give you a better experience",
            "assets/location.jpg",
            () async {
              await permissionViewModel.requestPermission();
              setState(() {
                _showLocationPermission = false; 
              });
            },
          ),
          secondChild: _buildPermissionWidget(
            context,
            "Allow Health Access",
            "We need access to Health data for better insights",
            "assets/location.jpg",
            () async {
              await permissionViewModel.requestActivityRecognitionPermission();
            },
          ),
          crossFadeState: _showLocationPermission
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 500),
        ),
      ),
    );
  }

  Widget _buildPermissionWidget(
    BuildContext context,
    String title,
    String description,
    String imagePath,
    VoidCallback onSurePressed,
  ) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: deviceHeight * 0.15,
          child: Image.asset(
            imagePath,
            fit: BoxFit.fitHeight,
          ),
        ),
        SizedBox(
          height: deviceHeight * 0.1,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: deviceHeight * 0.04,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: deviceHeight * 0.02),
        Text(
          description,
          style: TextStyle(
            color: Colors.white,
            fontSize: deviceHeight * 0.02,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: deviceHeight * 0.07,
        ),
        GestureDetector(
          onTap: onSurePressed,
          child: Container(
            height: deviceHeight * 0.06,
            width: deviceWidth,
            decoration: BoxDecoration(
              color: AppColors.limeGreen1,
              borderRadius: BorderRadius.circular(deviceWidth * 0.08),
            ),
            child: Center(
              child: Text(
                "Sure, I'd like that",
                style: TextStyle(
                  fontSize: deviceHeight * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: deviceHeight * 0.02,
        ),
        GestureDetector(
          onTap: () {
            // Handle "Not now" action if needed
          },
          child: SizedBox(
            height: deviceHeight * 0.06,
            width: deviceWidth,
            child: Center(
              child: Text(
                "Not now",
                style: TextStyle(
                  fontSize: deviceHeight * 0.02,
                  fontWeight: FontWeight.bold,
                  color: AppColors.limeGreen1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
