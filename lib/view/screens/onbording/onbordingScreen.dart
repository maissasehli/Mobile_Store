// lib/view/screens/onboarding/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storee/controller/onbordingcontroller.dart';
import 'package:storee/core/constants/color.dart';
import 'package:storee/data/datasource/static/onbording_static.dart';
import 'package:storee/view/widgets/onbording/PageIndicator.dart';
import 'package:storee/view/widgets/onbording/gradient_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Design Elements
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryWithOpacity,
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryWithOpacity,
              ),
            ),
          ),
          
          SafeArea(
            child: Obx(() => Column(
              children: [
                // Skip Button
                if (!controller.isLastPage)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, top: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowColor,
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: controller.navigateToLogin,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                // Page Content
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.pageCount,
                    onPageChanged: controller.onPageChanged,
                    itemBuilder: (context, index) {
                      final page = OnboardingStatic.pages[index];
                      return AnimatedBuilder(
                        animation: controller.pageController,
                        builder: (context, child) {
                          return Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Image Container with Animation
                                    TweenAnimationBuilder<double>(
                                      duration: const Duration(milliseconds: 800),
                                      tween: Tween(begin: 0.0, end: 1.0),
                                      curve: Curves.easeOutBack,
                                      builder: (context, value, child) {
                                        return Transform.scale(
                                          scale: value,
                                          child: Container(
                                            height: constraints.maxHeight * 0.5,
                                            width: double.infinity,
                                            margin: const EdgeInsets.symmetric(horizontal: 20),
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius: BorderRadius.circular(30),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.primaryWithOpacity,
                                                  blurRadius: 20,
                                                  offset: const Offset(0, 10),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(30),
                                              child: Image.asset(
                                                page.imagePath,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: constraints.maxHeight * 0.05),
                                    
                                    // Title with Animation
                                    Flexible(
                                      child: TweenAnimationBuilder<double>(
                                        duration: const Duration(milliseconds: 800),
                                        tween: Tween(begin: 0.0, end: 1.0),
                                        curve: Curves.easeOut,
                                        builder: (context, value, child) {
                                          return Opacity(
                                            opacity: value,
                                            child: Transform.translate(
                                              offset: Offset(0, 30 * (1 - value)),
                                              child: Text(
                                                page.title,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AppColors.textPrimary,
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.2,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: constraints.maxHeight * 0.02),
                                    
                                    // Subtitle with Animation
                                    Flexible(
                                      child: TweenAnimationBuilder<double>(
                                        duration: const Duration(milliseconds: 800),
                                        tween: Tween(begin: 0.0, end: 1.0),
                                        curve: Curves.easeOut,
                                        builder: (context, value, child) {
                                          return Opacity(
                                            opacity: value,
                                            child: Transform.translate(
                                              offset: Offset(0, 30 * (1 - value)),
                                              child: Text(
                                                page.subtitle,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AppColors.textSecondary,
                                                  fontSize: 16,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // Bottom Navigation Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowColor,
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PageIndicator(
                        pageCount: controller.pageCount,
                        currentPage: controller.currentPage.value,
                      ),
                      const SizedBox(height: 24),
                      GradientButton(
                        onPressed: () {
                          if (controller.isLastPage) {
                            controller.navigateToLogin();
                          } else {
                            controller.nextPage();
                          }
                        },
                        child: Text(
                          controller.isLastPage ? "Get Started" : "Next",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}