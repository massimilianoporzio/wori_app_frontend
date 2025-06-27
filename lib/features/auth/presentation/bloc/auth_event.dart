part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String? email;

  final String password;

  const LoginRequested({this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String username;
  final String password;

  const RegisterRequested({
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [email, username, password];
}

class RefreshTokenRequested extends AuthEvent {
  const RefreshTokenRequested();
}

class LogoutRequested extends AuthEvent {}

class AppStarted extends AuthEvent {}
