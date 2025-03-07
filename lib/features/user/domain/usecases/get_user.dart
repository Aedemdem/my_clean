import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserList implements UseCase<List<User>, Params> {
  final UserRepository repository;

  GetUserList(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(Params params) async {
    return await repository.getUserList(params.page);
  }
}

class Params extends Equatable {
  final int page;

  const Params({required this.page});

  @override
  List<Object> get props => [page];
}