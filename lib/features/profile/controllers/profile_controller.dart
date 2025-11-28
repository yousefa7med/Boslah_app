import 'package:get/get.dart';
import '../../../core/services/supabase_services/auth_service.dart';

class ProfileController extends GetxController {
  final AuthService _authService = AuthService();

  final fullName = ''.obs;
  final email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserName();
    loadEmail();
  }

  Future<void> loadUserName() async {
    fullName.value = await _authService.getCurrentUserFullName();
  }

  Future<void> loadEmail() async {
    email.value = (await _authService.getCurrentEmail())!;
  }
}
