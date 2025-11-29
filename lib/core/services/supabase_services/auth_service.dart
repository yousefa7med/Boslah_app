import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main.dart';

class AuthService {
  // Future<bool> register(String fullName, String email, String password) async {
  //   try {
  //     final response = await cloud.auth.signUp(
  //       password: password,
  //       email: email,
  //     );
  //     final user = response.user;
  //
  //     if (user != null) {
  //       await cloud.from('profiles').insert({
  //         'id': user.id,
  //         'full_name': fullName,
  //       });
  //     }
  //
  //     return true;
  //   } catch (e) {
  //     if (e.toString().contains("User already registered") ||
  //         e.toString().contains("User already exists")) {
  //       throw Exception("This email is already registered");
  //     }
  //
  //     throw Exception("Registration failed, please try again");
  //   }
  // }
  Future<String?> register(
    String fullName,
    String email,
    String password,
  ) async {
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

      return null;
    } on AuthException catch (e) {
      return e.message;
    } on PostgrestException catch (e) {
      return e.message;
    } catch (e) {
      return "Registration failed, please try again";
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      await cloud.auth.signInWithPassword(email: email, password: password);

      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Login failed, please try again";
    }
  }

  Future<String?> logout() async {
    try {
      await cloud.auth.signOut();
      return null; // done
    } catch (e) {
      return "Logout failed, please try again";
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
