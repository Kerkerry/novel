import 'package:novel/core/usecase/usecase.dart';
import 'package:novel/core/utils/typedef.dart';
import 'package:novel/src/authentication/data/model/book_model.dart';
import 'package:novel/src/authentication/domain/repositories/book_repository.dart';

class UpdateBook extends UseCaseWithParams<void, BookModel>{
  const UpdateBook(this._bookRepository);
  final BookRepository _bookRepository;
  @override
  ResultFuture<void> call(BookModel params)async=>_bookRepository.updateBook(id: params.id, book: params);

}