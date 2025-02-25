import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_clean/features/user/domain/usecases/get_detail_user.dart';
import 'package:my_clean/features/user/presentation/bloc/user_detail_bloc.dart';

import 'core/network/network_info.dart';
import 'core/usecases/usecase.dart';
import 'features/user/data/datasources/user_remote_data_source.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecases/get_user.dart';
import 'features/user/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - User
  // Bloc
  sl.registerFactory(() => UserBloc(getUserList: sl()));
  sl.registerFactory(() => UserDetailBloc(getUserDetail: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetUserList(sl()));
  sl.registerLazySingleton(() => GetUserDetail(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImpl(client: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => UseCase);

  //! External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
}