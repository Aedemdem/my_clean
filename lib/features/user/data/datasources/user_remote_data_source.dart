import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/user_list_model.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserListModel> getUserList(int page);
  Future<UserModel> getUserDetail(int page);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserListModel> getUserList(int page) async {
    try {
      final response = await client.get(
        '${Constants.baseUrl}${Constants.userListEndpoint}?page=$page&per_page=10',
        options: Options(
          headers: {
            'content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['data'] != null) {
          return UserListModel.fromJson(responseData);
        } else {
          throw ServerException(
              statusCode: response.statusCode!,
              message: responseData['message'] ?? 'Data Kosong',
              status: responseData['status'] ?? 'error');
        }
      } else {
        throw ServerException(
            statusCode: response.statusCode!,
            message: response.data['message'] ?? 'Unknown Error',
            status: response.data['status'] ?? 'error');
      }
    } on DioException catch (e) {
      throw ServerException(
          statusCode: e.response?.statusCode ?? 500,
          message: e.response?.data['message'] ?? 'Unknown Error',
          status: e.response?.data['status'] ?? 'error');
    }
  }

  @override
  Future<UserModel> getUserDetail(int id) async {
    try {
      final response = await client.get(
        '${Constants.baseUrl}${Constants.userDetailEndpoint}/$id',
        options: Options(
          headers: {
            'content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else if (response.statusCode == 404) {
        throw ServerException(
            statusCode: response.statusCode!,
            message: response.data['error'] ?? 'User not found',
            status: 'error');
      } else {
        throw ServerException(
            statusCode: response.statusCode!,
            message: response.data['message'] ?? 'Unknown Error',
            status: 'error');
      }
    } on DioException catch (e) {
      throw ServerException(
          statusCode: e.response?.statusCode ?? 500,
          message: e.response?.data['message'] ?? 'Unknown Error',
          status: e.response?.data['status'] ?? 'error');
    }
  }
}