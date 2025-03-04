import 'package:get/get.dart';
import 'package:storee/core/constants/routes.dart';

abstract class SuccessResetPassController extends GetxController {
  gotoPageLogin();
}

class SuccessResetPassControllerImp extends SuccessResetPassController {
  @override
  gotoPageLogin() {
    Get.offAllNamed(AppRoute.login);
  }
}
