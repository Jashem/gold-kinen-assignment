import 'package:assignment/posts/repositories/post_repository.dart';
import 'package:assignment/users/blocs/users_bloc/users_bloc.dart';
import 'package:assignment/users/view/users_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../users/repositories/user_repository.dart';
import '../constants.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => Dio()..options = BaseOptions(baseUrl: baseURI),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(
            RepositoryProvider.of<Dio>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => PostRepository(
            RepositoryProvider.of<Dio>(context),
          ),
        ),
      ],
      child: MaterialApp(
        home: BlocProvider(
          create: (context) => UsersBloc(context.read<UserRepository>())
            ..add(const UsersEvent.fetched()),
          child: const UsersPage(),
        ),
      ),
    );
  }
}
