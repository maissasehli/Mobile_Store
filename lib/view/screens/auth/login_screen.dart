import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storee/controller/auth/login_controller.dart';
import 'package:storee/controller/auth/google_auth_controller.dart'; // Import the Google auth controller
import 'package:storee/core/constants/color.dart';
import 'package:storee/core/constants/imageasset.dart';
import 'package:storee/core/functions/alertexitapp.dart';
import 'package:storee/core/functions/validinput.dart';
import 'package:storee/view/widgets/auth/CustomTextTitleAuth.dart';
import 'package:storee/view/widgets/auth/customTextBodyAuth.dart';
import 'package:storee/view/widgets/auth/custombuttonAuth.dart';
import 'package:storee/view/widgets/auth/customtextformauth.dart';
import 'package:storee/view/widgets/auth/logoauth.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize and get Google auth controller
    final GoogleAuthController googleAuthController = Get.put(GoogleAuthController());
    
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        alertExitApp();
      },
      child: GetBuilder<LoginControllerImp>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: controller.formstate,
                  child: Column(
                    children: [
                      // Top Section with Logo and Welcome Text
                      const LogoAuth(),
                      const SizedBox(height: 10),
                      const CustomTextTitleAuth(
                        text: "Welcome back !",
                      ),
                      const SizedBox(height: 15),
                      const CustomTextBodyAuth(
                        text: 'Sign in to continue',
                      ),

                      const SizedBox(height: 40),

                      // Form Section
                      CustomTextFormAuth(
                        validator: (val) => validInput(val!, 5, 100, "email"),
                        controller: controller.email,
                        hinttext: "Enter Your Email",
                        iconData: Icons.email_outlined,
                        labeltext: "Email",
                      ),
                      const SizedBox(height: 20),
                      GetBuilder<LoginControllerImp>(
                        builder: (controller) => CustomTextFormAuth(
                          validator: (val) => validInput(val!, 8, 30, "password"),
                          controller: controller.password,
                          hinttext: "Enter Your Password",
                          labeltext: "Password",
                          iconData: Icons.lock_outline,
                          onTapIcon: () {
                            controller.showPassword();
                          },
                          obscureText: controller.isShowPassword,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => controller.goToForgetPassword(),
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Sign In Button
                      CustomButtonAuth(
                        text: "Sign In",
                        onPressed: () => controller.login(),
                      ),
                      const SizedBox(height: 30),

                      // Social Login Section
                      const Text(
                        "Or continue with",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Google sign in button
                          Obx(() => _buildSocialButton(
                            AppImageAsset.googleIcon,
                            () {
                              googleAuthController.signInWithGoogle();
                            },
                            isLoading: googleAuthController.isLoading.value,
                          )),
                          const SizedBox(width: 20),
                          _buildSocialButton(
                            AppImageAsset.facebookIcon,
                            () {
                              // Handle Facebook sign in
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 1),

                      // Bottom Section
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            TextButton(
                              onPressed: () => controller.goToSignUp(),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String iconPath, VoidCallback onPressed, {bool isLoading = false}) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.inactiveIndicator),
          borderRadius: BorderRadius.circular(12),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              )
            : SvgPicture.asset(
                iconPath,
                height: 24,
                width: 24,
              ),
      ),
    );
  }
}