import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novels/src/authentication/domain/entities/book.dart';
import 'package:novels/src/authentication/domain/usecases/book/create_book.dart';
import 'package:novels/src/authentication/domain/usecases/book/get_books.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  final CreateBook _createBook;
  final GetBooks _getBooks;
  BookCubit({required GetBooks getBooks, required CreateBook createBook})
      : _createBook = createBook,
        _getBooks = getBooks,
        super(BookInitial());

  Future<void> createBook(
      {required String title,
      required String description,
      required String author}) async {
    emit(const CreatingBook());
    final result = await _createBook(
        BookParams(title: title, description: description, author: author));

    result.fold((failure) => emit(BookAuthError(failure.message)),
        (r) => emit(const BookCreated()));
  }

  Future<void> getBooks() async {
    emit(const GettingBooks());
    final result = await _getBooks();

    result.fold((failure) => emit(BookAuthError(failure.message)),
        (books) => emit(BooksLoaded(books)));
  }
}
