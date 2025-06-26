import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String username;

  const UserEntity({
    required this.id,
    required this.email,
    required this.username,
  });

  @override
  List<Object?> get props => [email, id, username];

  @override
  bool? get stringify => true;
}
