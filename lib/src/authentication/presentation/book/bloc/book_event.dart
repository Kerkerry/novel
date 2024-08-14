part of 'book_bloc.dart';

sealed class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class CreateBookEvent extends BookEvent{
  final String title;
  final String description;
  final String author;
  final String createdAt;
  const CreateBookEvent({required this.title, required this.description, required this.author, required this.createdAt});
}

class GetBooksEvent extends BookEvent{
  const GetBooksEvent();
}

class UpdateBookEvent extends BookEvent{
  final BookModel updatedBook;
  const UpdateBookEvent(this.updatedBook);
    @override
  List<Object> get props => [updatedBook.id];
}

class DeleteBookEvent extends BookEvent{
  final String id;
  const DeleteBookEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CheckInternetConnectionEvent extends BookEvent{
  const CheckInternetConnectionEvent();
}

