import 'package:flutter/material.dart';
import '../../../../core/constants/color.dart';
import '../../../../data/datasource/static/onbording_static.dart';

class OnboardingContent extends StatelessWidget {
  final PageController pageController;
  final int index;

  const OnboardingContent({
    super.key,
    required this.pageController,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final page = OnboardingStatic.pages[index];

    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildImage(constraints, page.imagePath),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  _buildTitle(page.title),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  _buildSubtitle(page.subtitle),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildImage(BoxConstraints constraints, String imagePath) {
    return TweenAnimationBuilder<double>(
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
              boxShadow: const [
                BoxShadow(
                  color: AppColors.primaryWithOpacity,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle(String title) {
    return Flexible(
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
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
    );
  }

  Widget _buildSubtitle(String subtitle) {
    return Flexible(
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
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
