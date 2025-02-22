import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storee/controller/onbordingcontroller.dart';
import 'package:storee/core/constants/color.dart';
import 'package:storee/core/constants/routes.dart';
import 'package:storee/core/localization/changelocal.dart';
import 'package:storee/view/widgets/Language/custombuttomlang.dart';

class Language extends GetView<LocaleController> {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize OnboardingController
    Get.put(OnboardingController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Select Language'.tr,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildLanguageCard(
              title: 'English',
              subtitle: 'English',
              languageCode: 'en',
              icon: Icons.language,
            ),
            const SizedBox(height: 16),
            _buildLanguageCard(
              title: 'العربية',
              subtitle: 'Arabic',
              languageCode: 'ar',
              icon: Icons.language,
            ),
            const Spacer(),
            CustomBottomLanguage(
              text: 'Continue'.tr,
              onPressed: () => Get.toNamed(AppRoute.onBoarding),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard({
    required String title,
    required String subtitle,
    required String languageCode,
    required IconData icon,
  }) {
    return GetBuilder<LocaleController>(
      builder: (controller) {
        bool isSelected = controller.language?.languageCode == languageCode;
        return Card(
          elevation: isSelected ? 8 : 2,
          shadowColor:
              isSelected ? AppColors.primary.withOpacity(0.5) : Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
          ),
          child: InkWell(
            onTap: () {
              controller.changeLang(languageCode);
            },
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      color: AppColors.primary,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.primary,
                      size: 24,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
