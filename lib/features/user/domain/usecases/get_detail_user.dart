import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetUserDetail implements UseCase<User, Params> {
  final UserRepository repository;

  GetUserDetail(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.getUserDetail(params.id);
  }
}

class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}