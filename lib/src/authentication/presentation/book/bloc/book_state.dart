part of 'book_bloc.dart';

sealed class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

final class BookInitial extends BookState {}

class CreatingBookState extends BookState {
  const CreatingBookState();
}

class BookCreatedState extends BookState {
  const BookCreatedState();
}

class GettingBooksState extends BookState {
  const GettingBooksState();
}

class BooksLoadedState extends BookState {
  final List<Book> books;

  const BooksLoadedState(this.books);

  @override
  List<Object> get props => books.map((e) => e.id).toList();
}

class UpdatingBookState extends BookState {
  const UpdatingBookState();
}

class BookUpdatedState extends BookState {
  const BookUpdatedState();
}

class DeletingBookState extends BookState {
  const DeletingBookState();
}

class BookDeletedState extends BookState {
  const BookDeletedState();
}

// class CheckInternetConnectionState extends BookState{
//   const CheckInternetConnectionState();
// }

class InternetConnectedState extends BookState {
  const InternetConnectedState(this.notConnected);
  final bool notConnected;
  @override
  List<Object> get props => [notConnected];
}

class InternetNotConnectedState extends BookState {
  const InternetNotConnectedState(this.connected);
  final bool connected;
  @override
  List<Object> get props => [connected];
}

class BookErrorState extends BookState {
  final String message;
  const BookErrorState(this.message);
  @override
  List<Object> get props => [message];
}
