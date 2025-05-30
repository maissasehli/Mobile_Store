// customTextBodyAuth.dart
import 'package:flutter/material.dart';
import 'package:storee/core/constants/color.dart';

class CustomTextBodyAuth extends StatelessWidget {
  final String text;

  const CustomTextBodyAuth({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textPrimary,
              height: 1.5,
            ),
      ),
    );
  }
}
