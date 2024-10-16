import 'dart:convert';

import 'package:colin_hanbury_frontend/services/registration_service.dart';
import 'package:crypto/crypto.dart';

class RegistrationRepo {
  final RegistrationService registrationAPI = RegistrationService();

  Future<String> register(
      String forename, String surname, String email, String password) async {
    forename.trim();
    surname.trim();
    email.toLowerCase().trim();
    password.trim();
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    String encryptedPassword = hash.toString();
    final dynamic response = await registrationAPI.register(
        forename, surname, email, encryptedPassword);
    return response['message'];
    // return User.fromJson(response);
  }
}
