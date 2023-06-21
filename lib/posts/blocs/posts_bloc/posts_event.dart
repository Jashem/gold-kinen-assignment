part of 'posts_bloc.dart';

@freezed
class PostsEvent with _$PostsEvent {
  const factory PostsEvent.started() = _Started;
  const factory PostsEvent.fetched(int userId) = _Fetched;
}
