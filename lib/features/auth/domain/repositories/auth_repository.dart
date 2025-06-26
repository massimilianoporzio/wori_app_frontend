import 'package:wori_app_frontend/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> register({
    required String email,
    required String password,
    required String name,
  });

  Future<UserEntity> login({
    required String email,
    required String password,
  });
}
