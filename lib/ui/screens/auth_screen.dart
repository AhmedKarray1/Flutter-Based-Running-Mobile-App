import 'package:flutter/material.dart';
import 'package:running_app/ui/presentation/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.darkGray1,
      body: Column(
        children: [
          SizedBox(height: deviceHeight * 0.06),
          Container(
            padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.07),
            height: deviceHeight * 0.4,
            width: deviceWidth,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage(
                  'assets/running.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.07),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: deviceWidth * 0.1, vertical: deviceHeight * 0.03),
              width: deviceWidth,
              decoration: BoxDecoration(
                color: AppColors.limeGreen1,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    deviceHeight * 0.1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Run',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: deviceHeight * 0.02),
                  const Text(
                    'Running is a powerful way to clear your mind, strengthen your body, and feel the freedom of movement with every stride.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: deviceHeight * 0.05),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkGray1,
                      borderRadius: BorderRadius.all(
                        Radius.circular(deviceWidth * 0.04),
                      ),
                    ),
                    width: deviceWidth * 0.4,
                    padding:
                        EdgeInsets.symmetric(vertical: deviceHeight * 0.013),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.limeGreen1,
                              fontSize: 18),
                        ),
                        SizedBox(width: deviceWidth * 0.02),
                        const Icon(Icons.arrow_right_alt,
                            color: AppColors.limeGreen1)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account? ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  )),
              Text(
                'Sign in',
                style: TextStyle(
                  color: AppColors.limeGreen1,
                  fontSize: 17,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
