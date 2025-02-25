import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/user/presentation/bloc/user_bloc.dart';
import 'features/user/presentation/pages/user_page.dart';
import 'injection_container.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    print('main app printed'); 
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => sl<UserBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const UserPage(page: 1,),
      ),
    );
  }
}