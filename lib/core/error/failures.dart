import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final int statusCode;
  final String message;
  final String status;

  const ServerFailure({required this.statusCode, required this.message, required this.status});
}

class NetworkFailure extends Failure {}
class CacheFailure extends Failure {} //todo: no usage