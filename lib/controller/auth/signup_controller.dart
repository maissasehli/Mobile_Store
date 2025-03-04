import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storee/core/constants/routes.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToSignIn();
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;

  bool isAcceptedTerms = false;
  
 bool isShowPassword = true;

  showPassword() {
    isShowPassword = !isShowPassword;
    update(); // Important: appeler update() pour rafraîchir l'UI
  }

  @override
  signUp() {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      if (!isAcceptedTerms) {
        Get.snackbar("Error", "Please accept the Terms and Conditions",
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }
      Get.offNamed(AppRoute.verifyCodeSignUp);
    }
  }

  @override
  goToSignIn() {
    Get.toNamed(AppRoute.login);
  }

  void setTermsAcceptance(bool value) {
    isAcceptedTerms = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }
}
