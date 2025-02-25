import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUserList(int page);
  Future<Either<Failure, User>> getUserDetail(int id);
}