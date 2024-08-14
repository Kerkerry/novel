part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}


class GetUsersEvent extends AuthenticationEvent{
  const GetUsersEvent();
}

class CreateUserEvent extends AuthenticationEvent{
  final String name;
  final String avatar;
  final String createdAt;
  const CreateUserEvent({required this.name,required this.avatar,required this.createdAt});

  @override
  List<Object> get props=>[name,avatar,createdAt];
}