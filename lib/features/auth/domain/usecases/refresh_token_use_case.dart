import 'package:dartz/dartz.dart';
import 'package:wori_app_frontend/core/error/failures.dart';
import 'package:wori_app_frontend/core/usecases/usecase.dart';
import 'package:wori_app_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:wori_app_frontend/features/auth/domain/repositories/auth_repository.dart';

class RefreshToken extends UseCase<User, NoParams> {
  final AuthRepository repository;

  RefreshToken(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.refreshToken();
  }
}
