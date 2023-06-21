part of 'new_post_bloc.dart';

@freezed
class NewPostEvent with _$NewPostEvent {
  const factory NewPostEvent.started() = _Started;
  const factory NewPostEvent.submited(
      {required int userId,
      required String title,
      required String body}) = _Submitted;
}
