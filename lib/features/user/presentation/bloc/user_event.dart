import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserListEvent extends UserEvent {
  final int page;

  const GetUserListEvent({required this.page});

  @override
  List<Object> get props => [page];
}