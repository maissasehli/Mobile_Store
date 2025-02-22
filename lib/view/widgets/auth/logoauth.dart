// logoauth.dart
import 'package:flutter/material.dart';
import 'package:storee/core/constants/imageasset.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImageAsset.logo,
      height: 170,
    );
  }
}