import 'package:assignment/posts/view/posts_page.dart';
import 'package:assignment/users/blocs/users_bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (state) {
              final users = state.users;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .push(PostsPage.route(userId: users[index].id));
                    },
                    title: Text(users[index].name),
                    subtitle: Text(users[index].email),
                  );
                },
              );
            },
            error: (value) => Center(
              child: Text(value.error),
            ),
          );
        },
      ),
    );
  }
}
