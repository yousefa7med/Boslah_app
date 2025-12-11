import 'package:Boslah/core/functions/is_dark.dart';
import 'package:get/get.dart';

import '../../../core/services/supabase_services/auth_service.dart';

class ProfileController extends GetxController {
  final AuthService _authService = AuthService();

  final fullName = ''.obs;
  final lightTheme = (!isDark()).obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserName();
  }

  Future<void> loadUserName() async {
    fullName.value = await _authService.getCurrentUserFullName();
  }

  String splitName(String name) {
    if (name.isEmpty) return "";
    List<String> parts = name.trim().split(" ");

    if (parts.isEmpty) return "";
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }
    return parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
  }
}
