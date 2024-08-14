import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novel/src/authentication/domain/entities/user.dart';
import 'package:novel/src/authentication/domain/usecases/create_user.dart';
import 'package:novel/src/authentication/domain/usecases/get_users.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final CreateUser _createUser;
  final GetUsers _getUsers;
  AuthenticationBloc({required CreateUser createUser,required GetUsers getUsers}) : 
  _createUser=createUser,
  _getUsers=getUsers,
  super(AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }

  Future<void> _createUserHandler(CreateUserEvent event, Emitter<AuthenticationState> emit)async{
    emit(const CreatingUserState());
    final response=await _createUser(CreateUserParams(name: event.name, avatar: event.avatar, createdAt: event.createdAt));

    response.fold((failure) => emit(AuthenticationErrorState(failure.message)), (_) => emit(const UserCreatedState()));
  }

  FutureOr<void> _getUsersHandler(GetUsersEvent event, Emitter<AuthenticationState> emit)async{
    emit(const GettingUsersState());
    final response=await _getUsers();
    response.fold((failure) => emit(AuthenticationErrorState(failure.message)), (users) => emit(UsersLoadedState(users)));
  }
}
