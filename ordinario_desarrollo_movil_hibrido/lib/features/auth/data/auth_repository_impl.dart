import '../domain/auth_repository.dart';
import '../domain/entities/user.dart';
import 'auth_remote_ds.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<User> login(String email, String password) {
    return remote.login(email, password);
  }

  @override
  Future<void> logout() async {
    // Podríamos limpiar cache, storage, etc.
  }
}
