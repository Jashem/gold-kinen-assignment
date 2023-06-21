import 'package:assignment/posts/blocs/new_post_bloc/new_post_bloc.dart';
import 'package:assignment/posts/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostPage extends StatefulWidget {
  static Route route({required int userId}) => MaterialPageRoute(
        builder: (context) => NewPostPage(userId: userId),
      );

  final int userId;
  const NewPostPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void submitForm(BuildContext ctx) {
    ctx.read<NewPostBloc>().add(
          NewPostEvent.submited(
              userId: widget.userId,
              title: _titleController.text,
              body: _bodyController.text),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewPostBloc(context.read<PostRepository>()),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("New Post"),
          ),
          body: BlocListener<NewPostBloc, NewPostState>(
            listener: (context, state) {
              state.maybeMap(
                success: (value) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(value.message)));
                },
                failure: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(value.message),
                    backgroundColor: Colors.red,
                  ));
                },
                orElse: () {},
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      label: Text("Title"),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _bodyController,
                    decoration: const InputDecoration(
                      label: Text("Body"),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () => submitForm(context),
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
