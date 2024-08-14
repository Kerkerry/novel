part of 'book_bloc.dart';

sealed class BookState extends Equatable {
  const BookState();
  
  @override
  List<Object> get props => [];
}

final class BookInitial extends BookState {}

class CreatingBook extends BookState{
  const CreatingBook();
}

class BookCreated extends BookState{
  const BookCreated();
}

class GettingBooks extends BookState{
  const GettingBooks();
}

class BooksLoaded extends BookState{
  final List<Book> books;
  const BooksLoaded(this.books);

  @override
  List<String> get props=>books.map((book) => book.id).toList();
}

class BookAuthError extends BookState{
  final String message;
  const BookAuthError(this.message);
  @override
  List<String> get props=>[message];
}

