import 'package:depi_graduation_project/core/errors/app_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main.dart';

class AuthService {
  Future<void> register(String fullName, String email, String password) async {
    try {
      final response = await cloud.auth.signUp(
        password: password,
        email: email,
      );
      final user = response.user;

      if (user != null) {
        await cloud.from('profiles').insert({
          'id': user.id,
          'full_name': fullName,
        });
      }
    } catch (e) {
      throw AppException(msg: "Registration failed, please try again");
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await cloud.auth.signInWithPassword(email: email, password: password);
    } on AuthException catch (e) {
      throw AppException(msg: e.message);
    } catch (e) {
      throw AppException(msg: "Login failed, please try again");
    }
  }

  Future<void> logout() async {
    try {
      await cloud.auth.signOut();
    } catch (e) {
      throw AppException(msg: "Logout failed, please try again");
    }
  }

  Future<String> getCurrentUserFullName() async {
    final userId = cloud.auth.currentUser!.id;

    final fullName = await cloud
        .from('profiles')
        .select('full_name')
        .eq('id', userId)
        .single();

    return fullName['full_name'] as String;
  }

  Future<String?> getCurrentEmail() async {
    return cloud.auth.currentUser!.email;
  }

  bool isLogin() => cloud.auth.currentSession != null;
}
