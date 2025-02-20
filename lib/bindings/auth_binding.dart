// lib/bindings/auth_binding.dart
import 'package:get/get.dart';
import 'package:storee/controller/auth_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
