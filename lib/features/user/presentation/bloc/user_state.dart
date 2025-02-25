import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserListLoaded extends UserState {
  final List<User> userList;

  const UserListLoaded({required this.userList});

  @override
  List<Object> get props => [userList];
}

class UserError extends UserState {
  final String message;

  const UserError({required this.message});

  @override
  List<Object> get props => [message];
}