import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novels/src/authentication/domain/entities/author.dart';
import 'package:novels/src/authentication/domain/usecases/author/create_author.dart';
import 'package:novels/src/authentication/domain/usecases/author/get_authors.dart';

part 'author_event.dart';
part 'author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  final CreateAuthor _createAuthor;
  final GetAuthors _getAuthors;
  AuthorBloc(
      {required CreateAuthor createAuthor, required GetAuthors getAuthors})
      : _createAuthor = createAuthor,
        _getAuthors = getAuthors,
        super(AuthorInitial()) {
    on<CreateAuthorEvent>(_createAuthorHandler);
    on<GetAuthorsEvent>(_getAuthorsHandler);
  }

  Future<void> _createAuthorHandler(
      CreateAuthorEvent event, Emitter<AuthorState> emit) async {
    emit(const CreatingAuthor());
    final result = await _createAuthor(
        AuthorParams(name: event.name, email: event.email, book: event.book));
    result.fold((failure) => emit(AuthorError(failure.message)),
        (_) => emit(const AuthorCreatedState()));
  }

  Future<void> _getAuthorsHandler(
      GetAuthorsEvent event, Emitter<AuthorState> emit) async {
    emit(const GetAuthorsState());
    final result = await _getAuthors();
    result.fold((failure) => emit(AuthorError(failure.message)),
        (authors) => emit(AuthorsLoaded(authors)));
  }
}
