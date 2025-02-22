import 'package:flutter/material.dart';
import 'package:storee/view/widgets/onbording/PageIndicator.dart';
import 'package:storee/view/widgets/onbording/gradient_button.dart';
import '../../../../core/constants/color.dart';

class BottomNavigation extends StatelessWidget {
  final int pageCount;
  final int currentPage;
  final bool isLastPage;
  final VoidCallback onNext;

  const BottomNavigation({
    super.key,
    required this.pageCount,
    required this.currentPage,
    required this.isLastPage,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            pageCount: pageCount,
            currentPage: currentPage,
          ),
          const SizedBox(height: 24),
          GradientButton(
            onPressed: onNext,
            child: Text(
              isLastPage ? "Get Started" : "Next",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}