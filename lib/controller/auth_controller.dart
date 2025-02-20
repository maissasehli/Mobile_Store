import 'package:get/get.dart';
import 'package:storee/main.dart';
import 'package:storee/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  
  Future<void> updatePassword(String newPassword) async {
    try {
      isLoading.value = true;
      await supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      Get.snackbar('Success', 'Password updated successfully');
      Get.offAllNamed(Routes.LOGIN); // Maintenant ça va marcher
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}