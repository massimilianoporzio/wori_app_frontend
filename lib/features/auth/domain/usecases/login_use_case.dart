import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wori_app_frontend/core/error/failures.dart';
import 'package:wori_app_frontend/core/usecases/usecase.dart';
import 'package:wori_app_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:wori_app_frontend/features/auth/domain/repositories/auth_repository.dart';

class LoginUser implements UseCase<User, LoginParams> {
  final AuthRepository repository;

  LoginUser(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  final String email;

  final String password;

  const LoginParams({
    required this.email,

    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
