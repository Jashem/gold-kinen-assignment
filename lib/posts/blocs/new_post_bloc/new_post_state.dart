part of 'new_post_bloc.dart';

@freezed
class NewPostState with _$NewPostState {
  const factory NewPostState.initial() = _Initial;
  const factory NewPostState.loading() = _Loading;
  const factory NewPostState.success(String message) = _Success;
  const factory NewPostState.failure(String message) = _Failure;
}
