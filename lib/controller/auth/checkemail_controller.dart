import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:storee/core/constants/routes.dart';

abstract class CheckEmailController extends GetxController {
  checkemail();
  goToverifyCodeSignUp();
}

class CheckEmailControllerImp extends CheckEmailController {
  late TextEditingController email;


  @override
  checkemail() {}

  @override
  
  goToverifyCodeSignUp() {
    Get.toNamed(AppRoute.verifyCodeSignUp);
  }
  @override
  void onInit(){
    super.onInit();
    email = TextEditingController();
  }
  @override
  void dispose(){
    email.dispose();
    super.dispose();
  }



}
