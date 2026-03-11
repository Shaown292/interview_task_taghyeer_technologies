import 'package:dio/dio.dart';
import '../model/user_model.dart';

class AuthRemoteDatasource {

  final Dio dio;

  AuthRemoteDatasource(this.dio);

  Future<UserModel> login(
      String username,
      String password,
      ) async {

    final response = await dio.post(
      "https://dummyjson.com/auth/login",
      data: {
        "username": username,
        "password": password,
      },
    );

    return UserModel.fromJson(response.data);

  }

}