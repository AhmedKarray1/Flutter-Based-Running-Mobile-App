import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:running_app/core/providers/view_model_provider.dart';
import 'package:running_app/ui/screens/signup_screen.dart';
import '../presentation/app_colors.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final authViewModel = ref.read(authViewModelProvider.notifier);
    print(authState.user);

    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.veryDarkGray,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Container(
                height: deviceHeight,
                padding: EdgeInsets.all(deviceWidth * 0.06),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.darkOliveGreen, AppColors.almostBlack],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.darkGray1),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: AppColors.limeGreen1),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.limeGreen1,
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth * 0.12,
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.05),
                    TextField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle:
                            const TextStyle(color: AppColors.limeGreen1),
                        filled: true,
                        fillColor: AppColors.darkGray1,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.email,
                            color: AppColors.limeGreen1),
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.03),
                    TextField(
                      controller: _passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle:
                            const TextStyle(color: AppColors.limeGreen1),
                        filled: true,
                        fillColor: AppColors.darkGray1,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon:
                            const Icon(Icons.lock, color: AppColors.limeGreen1),
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.02),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            color: AppColors.limeGreen1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.04),
                    GestureDetector(
                      onTap: () {
                        authViewModel.signIn(
                          _emailController.text,
                          _passwordController.text,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: deviceHeight * 0.015,
                            horizontal: deviceWidth * 0.2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.limeGreen1),
                        child: authState.isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 18, color: AppColors.darkGray1),
                              ),
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.06),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: AppColors.darkGray1,
                            thickness: 1,
                          ),
                        ),
                        SizedBox(width: deviceWidth * 0.04),
                        const Text(
                          'Or Continue With',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: deviceWidth * 0.04),
                        const Expanded(
                          child: Divider(
                            color: AppColors.darkGray1,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.06),
                    GestureDetector(
                      onTap: () {
                        // Handle Google sign-in action
                        authViewModel.signOut();
                      },
                      child: Container(
                        width: deviceWidth * 0.8,
                        padding: EdgeInsets.symmetric(
                            vertical: deviceHeight * 0.015,
                            horizontal: deviceWidth * 0.15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.darkGray1,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/google.png',
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(width: deviceWidth * 0.02),
                            const Text(
                              'Sign In with Google',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.06),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account? ',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: AppColors.limeGreen1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
