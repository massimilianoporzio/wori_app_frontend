import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wori_app_frontend/core/error/failures.dart';
import 'package:wori_app_frontend/core/usecases/usecase.dart';
import 'package:wori_app_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:wori_app_frontend/features/auth/domain/repositories/auth_repository.dart';

class RegisterUser implements UseCase<User, RegisterParams> {
  final AuthRepository repository;

  RegisterUser(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await repository.register(
      params.email,
      params.username,
      params.password,
    );
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String username;
  final String password;

  const RegisterParams({
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
