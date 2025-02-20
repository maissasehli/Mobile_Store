// lib/core/bindings/onboarding_binding.dart
import 'package:get/get.dart';
import 'package:storee/controller/onbordingcontroller.dart';

class OnboardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(OnboardingController());
  }
}