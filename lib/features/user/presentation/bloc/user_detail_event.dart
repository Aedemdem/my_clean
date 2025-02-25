import 'package:equatable/equatable.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class GetUserDetailEvent extends UserDetailEvent {
  final int id;

  const GetUserDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}