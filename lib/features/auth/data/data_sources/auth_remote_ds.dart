import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> login(
      String username, String password) async {
    final response = await dio.post(
      "/auth/login",
      data: {
        "username": username,
        "password": password,
        "expiresInMins": 30
      },
    );

    return response.data;
  }
}