import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novels/src/authentication/domain/entities/book.dart';
import 'package:novels/src/authentication/domain/usecases/book/create_book.dart';
import 'package:novels/src/authentication/domain/usecases/book/get_books.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final GetBooks _getBooks;
  final CreateBook _createBook;
  BookBloc({
    required CreateBook createBook,required GetBooks getBooks
  }) :
    _createBook=createBook,
    _getBooks=getBooks,
   super(BookInitial()) {
    on<GetBooksEvent>(_getBooksHandler);
    on<CreateBookEvent>(_createBookHandler);
  }

  Future<void> _createBookHandler(CreateBookEvent event,Emitter<BookState> emit)async{
    emit(const CreatingBook());
    final result=await _createBook(BookParams(title: event.title, description: event.description, author: event.author));

    result.fold((failure) => emit(BookAuthError(failure.message)), (_) => emit(const BookCreated()));
  }

  Future<void> _getBooksHandler(GetBooksEvent event,Emitter<BookState> emit)async{
    emit(const GettingBooks());
    final result=await _getBooks();
    result.fold((failure) => emit(BookAuthError(failure.message)), (books) => emit(BooksLoaded(books)));
  }
}
