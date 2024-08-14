import 'package:novel/core/utils/typedef.dart';
import 'package:novel/src/authentication/data/model/book_model.dart';
import 'package:novel/src/authentication/domain/entities/book.dart';

abstract class BookRepository{
  const BookRepository();

  ResultVoid createBook({required String title, required String description, required String author, required String createdAt});

  ResultVoid updateBook({required String id, required BookModel book}); 

  ResultVoid deleteBook(String id);

  ResultFuture<List<Book>> getBooks();
}
