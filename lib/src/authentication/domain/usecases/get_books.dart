import 'package:novel/core/usecase/usecase.dart';
import 'package:novel/core/utils/typedef.dart';
import 'package:novel/src/authentication/domain/entities/book.dart';
import 'package:novel/src/authentication/domain/repositories/book_repository.dart';

class GetBooks extends UseCaseWithoutParams<List<Book>> {
  const GetBooks(this._repository);
  final BookRepository _repository;

  @override
  ResultFuture<List<Book>> call() async => _repository.getBooks();
}
