// lib/controller/onboardingcontroller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storee/data/datasource/static/onbording_static.dart';

class OnboardingController extends GetxController {
  late PageController pageController;
  var currentPage = 0.obs;

  final int pageCount = OnboardingStatic.pages.length;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  bool get isLastPage => currentPage.value == pageCount - 1;

  void nextPage() {
    if (currentPage.value < pageCount - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  void navigateToLogin() {
    // Implement your navigation logic here
    Get.offAllNamed('/login');
  }
}