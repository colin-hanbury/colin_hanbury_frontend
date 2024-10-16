import 'package:colin_hanbury_frontend/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final dio = Dio();
  final baseURL = dotenv.env['BASE_URL'];

  Future<dynamic> login(String email, String password) async {
    Response response = await dio.post('$baseURL/auth/login',
        data: {'email': email, 'password': password});
    return response.data;
  }

  Future<dynamic> delete(User user) async {
    Response response = await dio.delete('$baseURL/delete/${user.id}');
    return response.data;
  }
}
