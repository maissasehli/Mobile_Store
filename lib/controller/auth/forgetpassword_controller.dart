// forgetpassword_controller.dart
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:storee/core/constants/routes.dart';

abstract class ForgetPasswordController extends GetxController {
  checkemail();
  goToVerfyCode();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  late TextEditingController email;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  
 bool isShowPassword = true;

  showPassword() {
    isShowPassword = !isShowPassword;
    update(); // Important: appeler update() pour rafraîchir l'UI
  }

  @override
  checkemail() {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      goToVerfyCode();
    }
  }

  @override
  goToVerfyCode() {
    Get.toNamed(AppRoute.verifyCode);
  }

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}