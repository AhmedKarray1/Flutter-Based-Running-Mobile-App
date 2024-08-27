import 'package:flutter/material.dart';
import 'package:running_app/ui/widgets/animated_popup.dart';
import '../presentation/app_colors.dart';

class PermissionWidget extends StatelessWidget {
  const PermissionWidget({
    super.key,
    required this.title,
    required this.description,
    required this.handlingPermission,
    required this.icon,
    required this.popupText,
  });

  final Widget icon; // Optional parameter
  final String title;
  final String description;
  final VoidCallback handlingPermission; 
  final String popupText;// Updated to VoidCallback for better type safety

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    void showPermissionPopup() {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return  AnimatedPopup( // Updated to const for better performance
            description: popupText,
          );
        },
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: deviceHeight * 0.15,
          child:icon
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
          onTap: handlingPermission,
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
            showPermissionPopup();
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
