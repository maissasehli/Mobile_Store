// CustomTextSignUpOrSignIn.dart
import 'package:flutter/material.dart';
import 'package:storee/core/constants/color.dart';

class CustomTextSignUpOrSignIn extends StatelessWidget {
  final String textOne;
  final String textTwo;
  final void Function() onTap;

  const CustomTextSignUpOrSignIn({
    Key? key,
    required this.textOne,
    required this.textTwo,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(textOne),
        InkWell(
          onTap: onTap,
          child: Text(
            textTwo,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
