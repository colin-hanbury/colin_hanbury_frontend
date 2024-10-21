import 'dart:convert';

import 'package:colin_hanbury_frontend/services/registration_service.dart';
import 'package:crypto/crypto.dart';

class RegistrationRepo {
  final RegistrationService registrationAPI = RegistrationService();

  Future<dynamic> register(
      String forename, String surname, String email, String password) async {
    try {
      forename.trim();
      surname.trim();
      email.toLowerCase().trim();
      password.trim();
      final bytes = utf8.encode(password);
      final hash = sha256.convert(bytes);
      String encryptedPassword = hash.toString();
      final dynamic response = await registrationAPI.register(
          forename, surname, email, encryptedPassword);
      return response['success'] == 'false'
          ? throw Exception([
              response['error'] ?? 'Registration error',
            ])
          : true;
    } catch (error) {
      return error;
    }
  }
}
