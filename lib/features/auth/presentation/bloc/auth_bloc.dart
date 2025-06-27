import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wori_app_frontend/core/error/failures.dart';
import 'package:wori_app_frontend/core/usecases/usecase.dart';
import 'package:wori_app_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:wori_app_frontend/features/auth/domain/usecases/login_use_case.dart';
import 'package:wori_app_frontend/features/auth/domain/usecases/logout_use_case.dart';
import 'package:wori_app_frontend/features/auth/domain/usecases/refresh_token_use_case.dart';
import 'package:wori_app_frontend/features/auth/domain/usecases/register_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final RefreshToken refreshTokenUseCase;
  final LogoutUser logoutUser;

  AuthBloc({
    required this.loginUser,
    required this.registerUser,
    required this.refreshTokenUseCase,
    required this.logoutUser,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<RefreshTokenRequested>(_onRefreshTokenRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AppStarted>(_onAppStarted);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final cachedUserEither = await loginUser.repository.getCachedUser();
    cachedUserEither.fold(
      (failure) => emit(AuthUnauthenticated()),
      (user) {
        if (user != null) {
          emit(AuthSuccess(user));
        } else {
          emit(AuthUnauthenticated());
        }
      },
    );
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await loginUser(
      LoginParams(
        email: event.email ?? '',

        password: event.password,
      ),
    );
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await registerUser(
      RegisterParams(
        email: event.email,
        username: event.username,
        password: event.password,
      ),
    );
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onRefreshTokenRequested(
    RefreshTokenRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await refreshTokenUseCase(NoParams());
    result.fold(
      (failure) {
        emit(AuthError(_mapFailureToMessage(failure)));
        emit(AuthUnauthenticated());
      },
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await logoutUser(NoParams());
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Server Error. Please try again later.';
      case CacheFailure _:
        return 'Cache Error. Please try again later.';
      case UnauthorizedFailure _:
        return 'Invalid credentials or session expired. Please login again.';
      case BadRequestFailure _:
        return 'Invalid input. Please check your data.';
      case OtherFailure _:
        return (failure as OtherFailure).message;
      default:
        return 'Unexpected error. Please try again.';
    }
  }
}
