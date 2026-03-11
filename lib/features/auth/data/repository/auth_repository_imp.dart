import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_sources/auth_remote_ds.dart';


class AuthRepositoryImpl implements AuthRepository {

  final AuthRemoteDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<User> login(
      String username,
      String password,
      ) {

    return datasource.login(username, password);

  }

}