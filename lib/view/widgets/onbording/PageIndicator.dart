import 'package:flutter/material.dart';
import 'package:storee/core/constants/color.dart';

class PageIndicator extends StatelessWidget {
  final int pageCount;
  final int currentPage;

  const PageIndicator({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? AppColors.primary
                : AppColors.inactiveIndicator,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              if (currentPage == index)
                BoxShadow(
                  color: AppColors.primaryShadow,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
        ),
      ),
    );
  }
}