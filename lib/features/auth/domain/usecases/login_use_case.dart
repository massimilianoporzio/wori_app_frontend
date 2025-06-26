import 'package:wori_app_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:wori_app_frontend/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<UserEntity> call(String email, String password) async {
    return await _authRepository.login(email: email, password: password);
  }
}
