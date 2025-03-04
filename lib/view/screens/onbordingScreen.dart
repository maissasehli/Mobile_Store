// lib/view/screens/onboarding/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storee/view/widgets/onbording/background_circles.dart';
import 'package:storee/view/widgets/onbording/bottom_navigation.dart';
import 'package:storee/view/widgets/onbording/onboarding_content.dart';
import 'package:storee/view/widgets/onbording/skip_button.dart';
import '../../controller/onbordingcontroller.dart';
import '../../core/constants/color.dart';


class Onboarding extends GetView<OnboardingController> {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const BackgroundCircles(),
          SafeArea(
            child: Obx(() => Column(
              children: [
                if (!controller.isLastPage)
                  SkipButton(onPressed: controller.navigateToLogin),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.pageCount,
                    onPageChanged: controller.onPageChanged,
                    itemBuilder: (context, index) => OnboardingContent(
                      pageController: controller.pageController,
                      index: index,
                    ),
                  ),
                ),
                BottomNavigation(
                  pageCount: controller.pageCount,
                  currentPage: controller.currentPage.value,
                  isLastPage: controller.isLastPage,
                  onNext: () {
                    if (controller.isLastPage) {
                      controller.navigateToLogin();
                    } else {
                      controller.nextPage();
                    }
                  },
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}