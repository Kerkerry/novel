part of 'author_cubit.dart';

sealed class AuthorState extends Equatable {
  const AuthorState();

  @override
  List<Object> get props => [];
}

final class AuthorInitial extends AuthorState {}
class AuthorCreatedState extends AuthorState {
  const AuthorCreatedState();
}

class CreatingAuthor extends AuthorState {
  const CreatingAuthor();
}

class GetAuthorsState extends AuthorState {
  const GetAuthorsState();
}

class AuthorsLoaded extends AuthorState {
  final List<Author> authors;
  const AuthorsLoaded(this.authors);

  @override
  List<String> get props => authors.map((author) => author.id).toList();
}

class AuthorError extends AuthorState{
  final String message;
  const AuthorError(this.message);

  @override
  List<String> get props=>[message];
}
