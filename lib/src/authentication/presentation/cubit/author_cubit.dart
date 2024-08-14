import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novels/src/authentication/domain/entities/author.dart';
import 'package:novels/src/authentication/domain/usecases/author/create_author.dart';
import 'package:novels/src/authentication/domain/usecases/author/get_authors.dart';

part 'author_state.dart';

class AuthorCubit extends Cubit<AuthorState> {
  final CreateAuthor _createAuthor;
  final GetAuthors _getAuthors;
  AuthorCubit({required CreateAuthor createAuthor,required GetAuthors getAuthors}) :
    _createAuthor=createAuthor,
    _getAuthors=getAuthors,
   super(AuthorInitial());


   Future<void> createAuthor({required String name,required String email,required String book})async{
    emit(const CreatingAuthor());
    final result=await _createAuthor(AuthorParams(name: name, email: email, book: book));

    result.fold((failure) => emit(AuthorError(failure.message)), (_) => emit(const AuthorCreatedState()));
   }

   Future<void> getAuthors()async{
    emit(const GetAuthorsState());
    final result=await _getAuthors();
    result.fold((l) => emit(AuthorError(l.message)), (authors) => emit(AuthorsLoaded(authors)));
   }
}

