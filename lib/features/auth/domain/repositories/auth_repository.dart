import 'package:dartz/dartz.dart';
import 'package:wori_app_frontend/core/error/failures.dart';
import 'package:wori_app_frontend/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(
    String email,
    String username,
    String password,
  );
  Future<Either<Failure, User>> refreshToken();
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User?>> getCachedUser();
}
