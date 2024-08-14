import 'package:novel/core/usecase/usecase.dart';
import 'package:novel/core/utils/typedef.dart';
import 'package:novel/src/authentication/domain/repositories/book_repository.dart';

class DeleteBook extends UseCaseWithParams<void,String>{
  const DeleteBook(this._repository);
  final BookRepository _repository;
  @override
  ResultFuture<void> call(String id)async=>_repository.deleteBook(id);
  
}