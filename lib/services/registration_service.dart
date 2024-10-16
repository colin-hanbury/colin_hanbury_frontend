import 'package:dio/dio.dart';

class RegistrationService {
  final dio = Dio();
  final baseURL = 'http://localhost:5050';

  Future<dynamic> register(
      String forename, String surname, String email, String password) async {
    Response response = await dio.post(
      '$baseURL/auth/register',
      data: {
        'forename': forename,
        'surname': surname,
        'email': email,
        'password': password
      },
    );
    return response.data;
  }
}
