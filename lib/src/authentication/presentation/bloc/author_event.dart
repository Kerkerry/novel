part of 'author_bloc.dart';

sealed class AuthorEvent extends Equatable {
  const AuthorEvent();

  @override
  List<Object> get props => [];
}

class GetAuthorsEvent extends AuthorEvent{
  const GetAuthorsEvent();
}

class CreateAuthorEvent extends AuthorEvent{
  final String name;
  final String email;
  final String book;
  const CreateAuthorEvent({required this.name, required this.email, required this.book});
  
  @override
  List<String> get props=>[name,email,book];
}
