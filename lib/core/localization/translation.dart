import 'package:get/get.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          "Select Language": "اختر اللغة",
          "Continue": "متابعة",
          "English": "الإنجليزية",
          "Arabic": "العربية",
        },
        "en": {
          "Select Language": "Select Language",
          "Continue": "Continue",
          "English": "English",
          "Arabic": "Arabic",
        },
      
      };
}