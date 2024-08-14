part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

class CreatingUserState extends AuthenticationState{
  const CreatingUserState();
}

class UserCreatedState extends AuthenticationState{
  const UserCreatedState();
}

class GettingUsersState extends AuthenticationState{
  const GettingUsersState();
}

class UsersLoadedState extends AuthenticationState{
  final List<User> users;
  const UsersLoadedState(this.users);

  @override
  List<String> get props=>users.map((e) => e.id).toList();
}

class AuthenticationErrorState extends AuthenticationState{
  final String message;
  const AuthenticationErrorState(this.message);

  @override
  List<String> get props=>[message];

}
