import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/user_detail_bloc.dart';
import '../widgets/user_detail_widget.dart';

class UserDetailPage extends StatelessWidget {
  final int userId;
  const UserDetailPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: BlocProvider(
        create: (context) => sl<UserDetailBloc>(),
        child:  UserDetailWidget(userId: userId),
      ),
    );
  }
}