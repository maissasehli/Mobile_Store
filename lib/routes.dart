import 'package:get/get.dart';
import 'package:storee/core/constants/routes.dart';
import 'package:storee/core/middleware/middleware.dart';
import 'package:storee/view/screens/auth/forgetpassword/fogot_password_screen.dart';
import 'package:storee/view/screens/auth/forgetpassword/verifycodesignup.dart';
import 'package:storee/view/screens/auth/login_screen.dart';
import 'package:storee/view/screens/auth/forgetpassword/resetPassword.dart';
import 'package:storee/view/screens/auth/signup_screen.dart';
import 'package:storee/view/screens/auth/forgetpassword/success_resetpassword.dart';
import 'package:storee/view/screens/auth/forgetpassword/success_signUp.dart';
import 'package:storee/view/screens/auth/forgetpassword/verifyCode.dart';
import 'package:storee/view/screens/home_screen.dart';
import 'package:storee/view/screens/language.dart';
import 'package:storee/view/screens/onbordingScreen.dart';


List<GetPage<dynamic>>? routes = [
  GetPage(name:"/", page: () => const Language(),middlewares:[
    Middleware()
  ]),

  // Auth
  GetPage(name: AppRoute.home, page: () => const HomeScreen()),

  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.signUp, page: () => const SignUp()),
  GetPage(name: AppRoute.forgetPassword, page: () => const ForgetPassword()),
  GetPage(name: AppRoute.verifyCode, page: () => const VerifyCode()),
  GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
  GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignUp()),
  GetPage(name: AppRoute.successResetPassword, page: () => const SuccessResetPassword()),
  GetPage(name: AppRoute.verifyCodeSignUp, page: () => const VerifyCodeSignUp()),

  // OnBoarding
  GetPage(name: AppRoute.onBoarding, page: () => const Onboarding()),
];



