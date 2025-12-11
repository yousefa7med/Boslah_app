import 'package:Boslah/core/errors/app_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  AuthService._internal();
  factory AuthService() => _instance;

  // Future<void> register(String fullName, String email, String password) async {
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
  //   } catch (e) {
  //     print("ERROR TYPE: ${e.runtimeType}");
  //     print("ERROR: $e");
  //     throw AppException(msg: "Registration failed, please try again");
  //   }
  // }

  Future<void> register(String fullName, String email, String password) async {
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user != null) {
        await Supabase.instance.client.from('profiles').insert({
          'id': user.id,
          'full_name': fullName,
        });
      }
    } catch (e) {
      if (e is AuthException) {
        if (e.message.toLowerCase().contains("registered") ||
            e.message.toLowerCase().contains("exists") ||
            e.message.toLowerCase().contains("email")) {
          throw AppException(msg: "This email is already in use");
        }
        throw AppException(msg: e.message);
      }

      if (e is PostgrestException) {
        throw AppException(msg: "Database error: ${e.message}");
      }

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
