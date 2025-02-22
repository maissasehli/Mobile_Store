// lib/core/bindings/onboarding_binding.dart
import 'package:get/get.dart';
import 'package:storee/controller/forgetpassword_controller.dart';
import 'package:storee/controller/login_controller.dart';
import 'package:storee/controller/resetPassword_controller.dart';
import 'package:storee/controller/signup_controller.dart';
import 'package:storee/controller/verifycode_controller.dart';
import 'package:storee/controller/verifycodesignup.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>SignUpControllerImp(),fenix:true );
    Get.lazyPut(()=>LoginControllerImp(),fenix:true );
    Get.lazyPut(()=>ResetPasswordControllerImp(),fenix:true );
    Get.lazyPut(()=>ForgetPasswordControllerImp(),fenix:true );
    Get.lazyPut(()=>VerifyCodeControllerImp(),fenix:true );
    Get.lazyPut(()=>VerifyCodeSignUpControllerImp(),fenix:true );
  }
}