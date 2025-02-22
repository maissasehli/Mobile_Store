import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:storee/controller/verifycodesignup.dart';
import 'package:storee/core/constants/color.dart';
import 'package:storee/view/widgets/auth/CustomTextTitleAuth.dart';
import 'package:storee/view/widgets/auth/customTextBodyAuth.dart';

class VerifyCodeSignUp extends StatelessWidget {
  const VerifyCodeSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ajout du GetBuilder pour accéder au controller
    return GetBuilder<VerifyCodeSignUpControllerImp>(
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Verification Code',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
            onPressed: () => Get.back(),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              const CustomTextTitleAuth(
                text: "Check Code",
              ),
              const SizedBox(height: 10),
              const CustomTextBodyAuth(
                text: "Please Enter the Digit Code Sent to maiisa@gmail",
              ),
              const SizedBox(height: 30),
              OtpTextField(
                fieldWidth: 50,
                borderRadius: BorderRadius.circular(20),
                numberOfFields: 5,
                borderColor: AppColors.primaryLight,
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  controller.goTosuccessSignUp();
                }, // end onSubmit
              ),
            ],
          ),
        ),
      ),
    );
  }
}