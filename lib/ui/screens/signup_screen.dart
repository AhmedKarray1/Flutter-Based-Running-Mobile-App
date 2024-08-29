import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:running_app/core/providers/view_model_provider.dart';
import 'package:running_app/ui/screens/map_screen.dart';
import '../presentation/app_colors.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final authViewModel = ref.read(authViewModelProvider.notifier);

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
                          'Sign Up',
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
                      controller: _usernameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle:
                            const TextStyle(color: AppColors.limeGreen1),
                        filled: true,
                        fillColor: AppColors.darkGray1,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.person,
                            color: AppColors.limeGreen1),
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.03),
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
                    SizedBox(height: deviceHeight * 0.03),
                    TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Age',
                        labelStyle:
                            const TextStyle(color: AppColors.limeGreen1),
                        filled: true,
                        fillColor: AppColors.darkGray1,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.calendar_today,
                            color: AppColors.limeGreen1),
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.02),
                    GestureDetector(
                      onTap: () async {
                        await authViewModel.signUp(
                          _usernameController.text,
                          _emailController.text,
                          _passwordController.text,
                          int.tryParse(_ageController.text) ?? 0,
                        );
                        print('authState: ${authState.user}');
                        if (authState.user != null) {
                          if (context.mounted) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MapScreen()));
                          }
                        }
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
                                    AlwaysStoppedAnimation(AppColors.darkGray1),
                              )
                            : const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 18, color: AppColors.darkGray1),
                              ),
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.06),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sign In',
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
