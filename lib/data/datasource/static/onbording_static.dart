import 'package:storee/core/constants/imageasset.dart';
import 'package:storee/data/model/onboarding_model.dart';

class OnboardingStatic {
  static List<OnboardingModel> pages = [
    OnboardingModel(
      imagePath: AppImageAsset.onBordingImageOne,
      title: "Mobile Shopping\nMade Easy",
      subtitle: "Shop your favorite products\nright from your smartphone",
    ),
    OnboardingModel(
      imagePath:AppImageAsset.onBordingImageTwo,
      title: "Quick & Easy\nPayments",
      subtitle: "Various payment methods\nfor seamless transactions",
    ),
    OnboardingModel(
      imagePath: AppImageAsset.onBordingImageThree,
      title: "Complete Shopping\nExperience",
      subtitle: "Browse, compare, and checkout\nwith just a few taps",
    ),
  ];
}