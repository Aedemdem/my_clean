import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_clean/features/user/presentation/widgets/shimmer_effect_list.dart';

import '../../domain/entities/user.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';
import '../../../../core/widgets/error_retry_widget.dart';
import '../widgets/user_card.dart';

import 'package:shimmer/shimmer.dart';


class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: UserListView(),
    );
  }
}

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final ScrollController _scrollController = ScrollController();
  bool isFetching = false;
  bool hasMoreData = true;
  int currentPage = 1;
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchUsers(currentPage);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9 && !isFetching && hasMoreData) {
      _fetchUsers(currentPage + 1);
    }
  }

  void _fetchUsers(int page) {
    if (!isFetching) {
      isFetching = true;
      context.read<UserBloc>().add(GetUserListEvent(page: page));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Widget _buildShimmerEffect() {
  //   return
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserListLoaded) {
          isFetching = false;
          if (state.userList.isEmpty) {
            hasMoreData = false;
          } else {
            currentPage++;
            users.addAll(state.userList);
          }
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            return const Center(child: Text('Initial'));
          } else if (state is UserLoading && users.isEmpty) {
            return ShimmerEffectList();
          } else if (state is UserListLoaded || users.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                hasMoreData = true;
                users.clear();
                currentPage = 1;
                _fetchUsers(1);
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: users.length + (hasMoreData ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < users.length) {
                    return UserCard(user: users[index]);
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            );
          } else if (state is UserError) {
            return ErrorRetryWidget(
              message: state.message,
              onRetry: () {
                setState(() {
                  users.clear(); // Kosongkan list sebelum fetch ulang
                  currentPage = 1;
                  hasMoreData = true;
                  isFetching = false; // Pastikan flag ini reset agar fetch bisa jalan
                });
                _fetchUsers(1);
              },
            );
          } else {
            return const Center(child: Text('Unknown State'));
          }
        },
      ),
    );
  }
}





