// reset_password.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storee/controller/auth/resetPassword_controller.dart';
import 'package:storee/core/constants/color.dart';
import 'package:storee/core/functions/validinput.dart';
import 'package:storee/view/widgets/auth/CustomTextTitleAuth.dart';
import 'package:storee/view/widgets/auth/customTextBodyAuth.dart';
import 'package:storee/view/widgets/auth/custombuttonAuth.dart';
import 'package:storee/view/widgets/auth/customtextformauth.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordControllerImp>(
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Reset Password',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
            onPressed: () => Get.back(),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: controller.formstate,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                const CustomTextTitleAuth(
                  text: "New Password",
                ),
                const SizedBox(height: 10),
                const CustomTextBodyAuth(
                  text: "Please Enter new password",
                ),
                const SizedBox(height: 20),
              CustomTextFormAuth(
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

const SizedBox(height: 20),

CustomTextFormAuth(
  validator: (val) {
    if (val != controller.password.text) {
      return "Passwords do not match";
    }
    return validInput(val!, 8, 30, "password");
  },
  controller: controller.repassword,
  hinttext: "Re Enter Your Password",
  labeltext: "Confirm Password",
  iconData: Icons.lock_outline,
  onTapIcon: () {
    controller.showRePassword();  // Utilise la nouvelle méthode
  },
  obscureText: controller.isShowRePassword,  // Utilise le nouvel état
),
            
                const SizedBox(height: 20),
                CustomButtonAuth(
                  text: "Save",
                  onPressed: () {
                    controller.resetpassword();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

