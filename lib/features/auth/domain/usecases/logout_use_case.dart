import 'package:dartz/dartz.dart';
import 'package:wori_app_frontend/core/error/failures.dart';
import 'package:wori_app_frontend/core/usecases/usecase.dart';
import 'package:wori_app_frontend/features/auth/domain/repositories/auth_repository.dart';

class LogoutUser extends UseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUser(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    repository.logout();
    return Future.value(const Right(null));
  }
}
