import 'package:get/get.dart';
import 'package:storee/core/constants/routes.dart';

abstract class SuccessSignUpController extends GetxController {
  gotoPageLogin();
}

class SuccessSignUpControllerImp extends SuccessSignUpController {
  @override
  gotoPageLogin() {
    Get.offAllNamed(AppRoute.login);
  }
}
