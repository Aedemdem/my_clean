import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<User>>> getUserList(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUserList = await remoteDataSource.getUserList(page);
        return Right(remoteUserList.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(statusCode: e.statusCode, message: e.message, status: e.status));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUserDetail(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUserList = await remoteDataSource.getUserDetail(page);
        return Right(remoteUserList.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(statusCode: e.statusCode, message: e.message, status: e.status));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}