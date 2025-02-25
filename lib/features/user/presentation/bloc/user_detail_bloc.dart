import 'package:my_clean/features/user/presentation/bloc/user_detail_event.dart';
import 'package:my_clean/features/user/presentation/bloc/user_detail_state.dart';

import '../../../../core/error/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_detail_user.dart';


class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final GetUserDetail getUserDetail;
  UserDetailBloc({required this.getUserDetail}) : super(UserDetailInitial()) {
    on<GetUserDetailEvent>((event, emit) async {
      emit(UserDetailLoading());
      final result = await getUserDetail(Params(id: event.id));
      result.fold(
            (failure) => emit(UserDetailError(message: _mapFailureToMessage(failure))),
            (user) => emit(UserDetailLoaded(user: user)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      default:
        return 'Unexpected Error';
    }
  }
}