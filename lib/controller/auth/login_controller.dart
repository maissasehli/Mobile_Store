import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:storee/core/constants/routes.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;

 bool isShowPassword = true;

  showPassword() {
    isShowPassword = !isShowPassword;
    update(); // Important: appeler update() pour rafraîchir l'UI
  }

  @override
  login() {
    var formdara = formstate.currentState;
    if (formdara!.validate()) {
      print('valid form');
    } else {
      print('invalid form');
    }
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }
}
