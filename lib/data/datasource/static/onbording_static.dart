import 'package:storee/data/model/onboarding_model.dart';

class OnboardingStatic {
  static List<OnboardingModel> pages = [
    OnboardingModel(
      imagePath: 'assets/onBordingImage/shop_store.png',
      title: "Mobile Shopping\nMade Easy",
      subtitle: "Shop your favorite products\nright from your smartphone",
    ),
    OnboardingModel(
      imagePath: 'assets/onBordingImage/shop_payment.png',
      title: "Quick & Easy\nPayments",
      subtitle: "Various payment methods\nfor seamless transactions",
    ),
    OnboardingModel(
      imagePath: 'assets/onBordingImage/shop_cart.png',
      title: "Complete Shopping\nExperience",
      subtitle: "Browse, compare, and checkout\nwith just a few taps",
    ),
  ];
}