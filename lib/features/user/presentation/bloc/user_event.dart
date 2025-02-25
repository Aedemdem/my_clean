import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class GetUserListEvent extends UserEvent {
  final int page;

  const GetUserListEvent({required this.page});

  @override
  List<Object> get props => [page];
}