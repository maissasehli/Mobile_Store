import 'package:get/get.dart';
import 'package:storee/core/constants/routes.dart';

abstract class VerifyCodeController extends GetxController {
  checkCode();
  goToResetPass();
}

class VerifyCodeControllerImp extends VerifyCodeController {
  late String verifycode;

  
  @override
  checkCode() {}

  @override
  goToResetPass() {
    Get.toNamed(AppRoute.resetPassword);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
