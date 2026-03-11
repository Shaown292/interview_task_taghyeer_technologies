import '../../domain/entities/user.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<User> login(String username, String password) async {

    final data = await remote.login(username, password);

    return UserModel.fromJson(data);
  }
}