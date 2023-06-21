import 'package:assignment/core/exceptions.dart';
import 'package:assignment/posts/repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/post.dart';

part 'posts_event.dart';
part 'posts_state.dart';
part 'posts_bloc.freezed.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository _postRepository;
  PostsBloc(this._postRepository) : super(const _Initial()) {
    on<PostsEvent>((event, emit) async {
      await event.map(
        started: (_) async {
          emit(const PostsState.initial());
        },
        fetched: (event) async {
          await fetchPosts(event, emit);
        },
      );
    });
  }

  Future<void> fetchPosts(_Fetched event, Emitter<PostsState> emit) async {
    try {
      final posts = await _postRepository.getPostsByUserId(event.userId);
      emit(PostsState.loaded(posts));
    } on AppException catch (e) {
      emit(PostsState.error(e.errorMessage));
    }
  }
}
