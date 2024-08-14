import 'package:equatable/equatable.dart';
import 'package:novel/core/usecase/usecase.dart';
import 'package:novel/core/utils/typedef.dart';
import 'package:novel/src/authentication/domain/repositories/book_repository.dart';

class CreateBook extends UseCaseWithParams<void, BookParams> {
  const CreateBook(this._repository);
  final BookRepository _repository;
  
  @override
  ResultFuture<void> call(BookParams params)async=>_repository.createBook(title: params.title, description: params.description, author: params.author, createdAt: params.createdAt);
}

class BookParams extends Equatable {
  final String title;
  final String description;
  final String author;
  final String createdAt;

  const BookParams(
      {required this.title,
      required this.description,
      required this.author,
      required this.createdAt});
      
        @override
        List<Object?> get props => [title,description,author,createdAt];
}
