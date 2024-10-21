import 'dart:convert';

import 'package:colin_hanbury_frontend/models/user.dart';
import 'package:colin_hanbury_frontend/services/auth_service.dart';
import 'package:crypto/crypto.dart';

class AuthRepo {
  final AuthService authAPI = AuthService();

  Future<dynamic> login(String email, String password) async {
    try {
      email.toLowerCase().trim();
      password.trim();
      final bytes = utf8.encode(password);
      final hash = sha256.convert(bytes);
      String encryptedPassword = hash.toString();
      final dynamic response = await authAPI.login(email, encryptedPassword);
      return response['success'] == 'false'
          ? throw Exception([
              response['error'] ?? 'Registration error',
            ])
          : true;
    } catch (error) {
      return error;
    }
  }

  Future<User> logout(User user) async {
    return User(user.id, user.firstName, user.lastName, user.email, null);
  }

  Future<User?> deleteUser(User user) async {
    final dynamic response = await authAPI.delete(user);
    User deletedUser = User.fromJson(response);
    return deletedUser == user ? null : user;
  }
}
