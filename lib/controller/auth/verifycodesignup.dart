import 'package:get/get.dart';
import 'package:storee/core/constants/routes.dart';

abstract class VerifyCodeSignUpController extends GetxController {
  checkCode();
  goTosuccessSignUp();
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {
  late String verifycode;

  
  @override
  checkCode() {}

  @override
  goTosuccessSignUp() {
    Get.toNamed(AppRoute.successSignUp);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
