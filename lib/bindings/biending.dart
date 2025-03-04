// lib/core/bindings/onboarding_binding.dart
import 'package:get/get.dart';
import 'package:storee/controller/auth/forgetpassword_controller.dart';
import 'package:storee/controller/auth/login_controller.dart';
import 'package:storee/controller/auth/resetPassword_controller.dart';
import 'package:storee/controller/auth/signup_controller.dart';
import 'package:storee/controller/auth/verifycode_controller.dart';
import 'package:storee/controller/auth/verifycodesignup.dart';
import 'package:storee/core/services/services.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyServices(), fenix: true); // Register MyServices
    Get.lazyPut(() => SignUpControllerImp(), fenix: true);
    Get.lazyPut(() => LoginControllerImp(), fenix: true);
    Get.lazyPut(() => ResetPasswordControllerImp(), fenix: true);
    Get.lazyPut(() => ForgetPasswordControllerImp(), fenix: true);
    Get.lazyPut(() => VerifyCodeControllerImp(), fenix: true);
    Get.lazyPut(() => VerifyCodeSignUpControllerImp(), fenix: true);
  }
}
