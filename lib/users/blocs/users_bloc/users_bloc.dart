import 'package:assignment/core/exceptions.dart';
import 'package:assignment/users/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/user.dart';

part 'users_event.dart';
part 'users_state.dart';
part 'users_bloc.freezed.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository _userRepository;
  UsersBloc(this._userRepository) : super(const _Initial()) {
    on<UsersEvent>((event, emit) async {
      await event.map(
        started: (_) async {
          emit(const UsersState.initial());
        },
        fetched: (_) async {
          await fetchUsers(emit);
        },
      );
    });
  }

  Future<void> fetchUsers(Emitter<UsersState> emit) async {
    try {
      final users = await _userRepository.getUsers();
      emit(UsersState.loaded(users));
    } on AppException catch (e) {
      emit(UsersState.error(e.errorMessage));
    }
  }
}
