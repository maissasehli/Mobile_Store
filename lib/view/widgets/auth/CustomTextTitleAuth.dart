// CustomTextTitleAuth.dart
import 'package:flutter/material.dart';
import 'package:storee/core/constants/color.dart';

class CustomTextTitleAuth extends StatelessWidget {
  final String text;

  const CustomTextTitleAuth({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
