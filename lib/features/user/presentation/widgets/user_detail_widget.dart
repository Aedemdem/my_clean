import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_detail_bloc.dart';
import '../bloc/user_detail_event.dart';
import '../bloc/user_detail_state.dart';

class UserDetailWidget extends StatefulWidget {
  final int userId;
  const UserDetailWidget({super.key, required this.userId});

  @override
  State<UserDetailWidget> createState() => _UserDetailWidgetState();
}

class _UserDetailWidgetState extends State<UserDetailWidget> {
  @override
  void initState() {
    super.initState();
    context.read<UserDetailBloc>().add(GetUserDetailEvent(id: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailBloc, UserDetailState>(
      builder: (context, state) {
        if (state is UserDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserDetailLoaded) {
          final user = state.user;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.avatar),
                ),
                const SizedBox(height: 16),
                Text('ID: ${user.id}'),
                Text('Email: ${user.email}'),
                Text('Name: ${user.firstName} ${user.lastName}'),
              ],
            ),
          );
        } else if (state is UserDetailError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Unknown State'));
        }
      },
    );
  }
}