import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storee/controller/auth/forgetpassword_controller.dart';
import 'package:storee/core/constants/color.dart';
import 'package:storee/core/functions/validinput.dart';
import 'package:storee/view/widgets/auth/CustomTextTitleAuth.dart';
import 'package:storee/view/widgets/auth/customTextBodyAuth.dart';
import 'package:storee/view/widgets/auth/custombuttonAuth.dart';
import 'package:storee/view/widgets/auth/customtextformauth.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordControllerImp>(
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Forget Password',
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
          child: Form(
            key: controller.formstate,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                const CustomTextTitleAuth(
                  text: "Check Email",
                ),
                const SizedBox(height: 10),
                const CustomTextBodyAuth(
                  text: "Please enter your email address to receive a verification code",
                ),
                const SizedBox(height: 20),
                CustomTextFormAuth(
                  validator: (val) => validInput(val!, 5, 30, "email"),
                  controller: controller.email,
                  hinttext: "Enter Your Email",
                  labeltext: "Email",
                  iconData: Icons.email_outlined,
                ),
                const SizedBox(height: 20),
                CustomButtonAuth(
                  text: "Check",
                  onPressed: () {
                    controller.checkemail();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}