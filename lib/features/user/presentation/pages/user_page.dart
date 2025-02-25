import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_detail_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';
import '../widgets/user_card.dart';

class UserPage extends StatelessWidget {
  final int page;
  const UserPage({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<UserBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<UserDetailBloc>(),
          ),
        ],
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserInitial) {
              context.read<UserBloc>().add(GetUserListEvent(page: page));
              return const Center(child: Text('Initial'));
            } else if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserListLoaded) {
              if (state.userList.isEmpty) {
                return const Center(child: Text('Data Kosong'));
              }
              return ListView.builder(
                itemCount: state.userList.length,
                itemBuilder: (context, index) {
                  return UserCard(user: state.userList[index]);
                },
              );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Unknown State'));
            }
          },
        ),
      ),
    );
  }
}