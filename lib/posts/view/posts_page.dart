import 'package:assignment/posts/blocs/posts_bloc/posts_bloc.dart';
import 'package:assignment/posts/repositories/post_repository.dart';
import 'package:assignment/posts/view/new_post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  static Route route({required int userId}) => MaterialPageRoute(
        builder: (context) => PostsPage(userId: userId),
      );

  final int userId;

  const PostsPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc(context.read<PostRepository>())
        ..add(PostsEvent.fetched(userId)),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("Posts"),
          ),
          body: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              return state.map(
                initial: (_) => const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (state) {
                  final posts = state.posts;
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(posts[index].title),
                        subtitle: Text(posts[index].body),
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(NewPostPage.route(userId: userId));
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
