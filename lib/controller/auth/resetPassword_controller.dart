// reset_password_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:storee/core/constants/routes.dart';

abstract class ResetPasswordController extends GetxController {
  resetpassword();
  goToSuccessResetPassword();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  
  late TextEditingController password;
  late TextEditingController repassword;
  
  bool isShowPassword = true;
  bool isShowRePassword = true;  // Nouveau état pour le champ de confirmation

  showPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  showRePassword() {  // Nouvelle méthode pour le champ de confirmation
    isShowRePassword = !isShowRePassword;
    update();
  }
  
  bool isLoading = false;

  @override
  resetpassword() {
    if (formstate.currentState!.validate()) {
      if (password.text != repassword.text) {
        Get.snackbar(
          "Error",
          "Passwords do not match",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      
      isLoading = true;
      update();
      
      try {
        goToSuccessResetPassword();
      } catch (e) {
        Get.snackbar(
          "Error",
          "Failed to reset password. Please try again.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading = false;
        update();
      }
    }
  }

  @override
  goToSuccessResetPassword() {
    Get.offNamed(AppRoute.successResetPassword);
  }

  @override
  void onInit() {
    super.onInit();
    password = TextEditingController();
    repassword = TextEditingController();
  }

  @override
  void dispose() {
    password.dispose();
    repassword.dispose();
    super.dispose();
  }
}