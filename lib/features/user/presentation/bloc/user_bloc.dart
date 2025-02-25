import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_user.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserList getUserList;

  UserBloc({required this.getUserList}) : super(UserInitial()) {
    on<GetUserListEvent>((event, emit) async {
      emit(UserLoading());
      final failureOrUserList = await getUserList(Params(page: event.page));
      failureOrUserList.fold(
            (failure) => emit(UserError(message: _mapFailureToMessage(failure))),
            (userList) => emit(UserListLoaded(userList: userList)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        final serverFailure = failure as ServerFailure;
        if (serverFailure.status == 'error') {
          if (serverFailure.statusCode == 404) {
            return 'Data tidak ditemukan';
          } else if (serverFailure.statusCode == 500) {
            return 'Terjadi kesalahan di server. Silakan coba lagi nanti.';
          } else {
            return serverFailure.message;
          }
        } else {
          return serverFailure.message;
        }
      case NetworkFailure:
        return 'Tidak ada koneksi internet';
      default:
        return 'Terjadi kesalahan yang tidak terduga.';
    }
  }
}