part of 'users_bloc.dart';

@freezed
class UsersState with _$UsersState {
  const factory UsersState.initial() = _Initial;
  const factory UsersState.loaded(List<User> users) = _Loaded;
  const factory UsersState.error(String error) = _Error;
}
