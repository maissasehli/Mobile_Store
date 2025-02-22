import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:storee/controller/signup_controller.dart';
import 'package:storee/core/constants/color.dart';
import 'package:storee/core/functions/alertexitapp.dart';
import 'package:storee/view/widgets/auth/CustomTextTitleAuth.dart';
import 'package:storee/view/widgets/auth/customTextBodyAuth.dart';
import 'package:storee/view/widgets/auth/custombuttonAuth.dart';
import 'package:storee/view/widgets/auth/customtextformauth.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  String? validInput(String val, int min, int max, String type) {
    // Empty check
    if (val.isEmpty) {
      return "Can't be empty";
    }

    // Length validation
    if (val.length < min) {
      return "Can't be less than $min characters";
    }
    if (val.length > max) {
      return "Can't be more than $max characters";
    }

    // Type-specific validation
    switch (type) {
      case "username":
        if (!GetUtils.isUsername(val)) {
          return "Username can only contain letters, numbers and underscore";
        }
        break;
      case "email":
        if (!GetUtils.isEmail(val)) {
          return "Not a valid email";
        }
        break;
      case "password":
        if (!GetUtils.isLengthGreaterOrEqual(val, 8)) {
          return "Password must be at least 8 characters";
        }
        if (!val.contains(RegExp(r'[A-Za-z]')) || !val.contains(RegExp(r'[0-9]'))) {
          return "Password must contain both letters and numbers";
        }
        break;
      case "phone":
        if (!GetUtils.isPhoneNumber(val)) {
          return "Not a valid phone number";
        }
        if (val.length != 8) {
          return "Phone number must be 8 digits";
        }
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        alertExitApp();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Sign Up',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
            onPressed: () => Get.offNamed("/login"),
          ),
        ),
        body: GetBuilder<SignUpControllerImp>(
          builder: (controller) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: controller.formstate,
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  const CustomTextTitleAuth(
                    text: "Create Account ✨",
                  ),
                  const SizedBox(height: 10),
                  const CustomTextBodyAuth(
                    text: "Please fill in your details to get started",
                  ),
                  const SizedBox(height: 40),
                  CustomTextFormAuth(
                    validator: (val) => validInput(val ?? '', 3, 20, "username"),
                    controller: controller.name,
                    hinttext: "Enter Your Name",
                    labeltext: "Name",
                    iconData: Icons.person_outline,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormAuth(
                    validator: (val) => validInput(val ?? '', 5, 50, "email"),
                    controller: controller.email,
                    hinttext: "Enter Your Email",
                    labeltext: "Email",
                    iconData: Icons.email_outlined,
                  ),
                  const SizedBox(height: 20),
                  GetBuilder<SignUpControllerImp>(
                    builder: (controller) => CustomTextFormAuth(
                      validator: (val) => validInput(val ?? '', 8, 30, "password"),
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
                  const SizedBox(height: 20),
                  GetBuilder<SignUpControllerImp>(
                    builder: (controller) => CustomTextFormAuth(
                      validator: (val) {
                        if (val != controller.password.text) {
                          return "Passwords do not match";
                        }
                        return validInput(val ?? '', 8, 30, "password");
                      },
                      controller: controller.confirmPassword,
                      hinttext: "Confirm Your Password",
                      labeltext: "Confirm Password",
                      iconData: Icons.lock_outline,
                                  onTapIcon: () {
      controller.showPassword();
    },
    obscureText: controller.isShowPassword,
                    
                    ),
                  ),
                  const SizedBox(height: 20),
                  GetBuilder<SignUpControllerImp>(
                    builder: (controller) => _buildTermsCheckbox(context, controller),
                  ),
                  const SizedBox(height: 20),
                  CustomButtonAuth(
                    text: "Create Account",
                    onPressed: () {
                      if (controller.formstate.currentState!.validate()) {
                        controller.signUp();
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      InkWell(
                        onTap: () => controller.goToSignIn(),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
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
      ),
    );
  }

  Widget _buildTermsCheckbox(BuildContext context, SignUpControllerImp controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: controller.isAcceptedTerms,
              onChanged: (value) {
                controller.setTermsAcceptance(value ?? false);
              },
              activeColor: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(text: 'I agree to the '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}