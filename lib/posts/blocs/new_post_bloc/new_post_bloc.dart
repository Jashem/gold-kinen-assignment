import 'package:assignment/posts/repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/exceptions.dart';

part 'new_post_event.dart';
part 'new_post_state.dart';
part 'new_post_bloc.freezed.dart';

class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  final PostRepository _postRepository;

  NewPostBloc(this._postRepository) : super(const _Initial()) {
    on<NewPostEvent>((event, emit) async {
      await event.map(
        started: (_) async => const NewPostState.initial(),
        submited: (value) async {
          await createPost(value, emit);
        },
      );
    });
  }

  Future<void> createPost(_Submitted event, Emitter<NewPostState> emit) async {
    try {
      final String title = event.title;
      final String body = event.body;
      if (title.isEmpty || body.isEmpty) {
        emit(const NewPostState.failure("Please fillup the fields!"));
        return;
      }
      emit(const NewPostState.loading());
      await _postRepository.createPost(
        userId: event.userId,
        title: title,
        body: body,
      );
      emit(const NewPostState.success("Created succesfully"));
    } on AppException catch (e) {
      emit(NewPostState.failure(e.errorMessage));
    }
  }
}
