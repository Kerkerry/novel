import 'package:novels/core/usecase/usecase.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/book.dart';
import 'package:novels/src/authentication/domain/repository/book_repository.dart';

class GetBooks extends UseCaseWithoutParams<List<Book>>{
  const GetBooks(this._repository);
  final  BookRepository _repository;
  @override
  ResultFuture<List<Book>> call()async=>_repository.getBooks();
}