import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';
import 'user_model.dart';

part 'user_list_model.g.dart';

@JsonSerializable()
class UserListModel extends Equatable {
  final int page;
  @JsonKey(name: 'per_page')
  final int perPage;
  final int total;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final List<UserModel> data;

  const UserListModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) =>
      _$UserListModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserListModelToJson(this);

  List<User> toEntity() {
    return data.map((userModel) => userModel.toEntity()).toList();
  }

  @override
  List<Object?> get props => [page, perPage, total, totalPages, data];
}