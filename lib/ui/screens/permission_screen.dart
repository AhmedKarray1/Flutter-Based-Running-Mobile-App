import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:running_app/ui/app_colors.dart';
import 'package:running_app/ui/screens/map_screen.dart';
import '../../core/providers/view_model_provider.dart';

class PermissionScreen extends ConsumerWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final permissionState = ref.watch(permissionViewModelProvider);
    final permissionViewModel = ref.read(permissionViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.darkGray1,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceHeight * 0.15,
              child: Image.asset(
                "assets/location.jpg",
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.1,
            ),
            Text(
              "Allow your location",
              style: TextStyle(color: Colors.white, fontSize: deviceHeight * 0.04, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              "We will need your location to give you better experience",
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
              onTap: () async {
                await permissionViewModel.requestPermission();
                if (permissionState.isLocationPermissionGranted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MapScreen(),
                    ),
                  );
                }
              },
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
              onTap: () {},
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
            )
          ],
        ),
      ),
    );
  }
}
