import 'package:get/get.dart';
import 'package:storee/view/screens/onbording/onbordingScreen.dart';
import 'package:storee/view/screens/auth/Update_Password.dart';
import 'package:storee/view/screens/auth/login_screen.dart'; // Import la page login
import 'package:storee/bindings/onboarding_binding.dart';
import 'package:storee/bindings/auth_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.UPDATE_PASSWORD,
      page: () => const UpdatePasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
  ];
}
