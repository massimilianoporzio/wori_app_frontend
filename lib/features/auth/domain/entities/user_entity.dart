import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String username;
  final String? accessToken;
  final String? refreshToken;

  const User({
    required this.id,
    required this.email,
    required this.username,
    this.accessToken,
    this.refreshToken,
  });

  @override
  List<Object?> get props => [email, id, username, accessToken, refreshToken];

  @override
  bool? get stringify => true;
}
