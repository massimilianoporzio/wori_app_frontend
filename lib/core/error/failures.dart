// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;

  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => properties;
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class UnauthorizedFailure extends Failure {}

class BadRequestFailure extends Failure {}

class NetworkFailure extends Failure {}

class OtherFailure extends Failure {
  final String message;

  OtherFailure(this.message) : super([message]);
}
