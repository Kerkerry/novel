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
  const CreateBookEvent({required this.title,required this.description,required this.author});

  @override
  List<String> get props=>[title,description,author];
}

class GetBooksEvent extends BookEvent{
  const GetBooksEvent();
}