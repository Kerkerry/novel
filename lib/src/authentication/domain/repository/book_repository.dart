import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/book.dart';

abstract class BookRepository{
  const BookRepository();

  ResultFutureVoid createBook({required String title,required String description,required String author});
  ResultFuture<List<Book>> getBooks();
}