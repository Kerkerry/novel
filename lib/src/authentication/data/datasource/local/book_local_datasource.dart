import 'package:hive_flutter/hive_flutter.dart';
import 'package:novel/core/utils/typedef.dart';
import 'package:novel/src/authentication/data/model/book_model.dart';
import 'package:novel/src/authentication/domain/repositories/book_repository.dart';



class BookLocalDatasourceImplementation extends BookRepository{
  final Box<BookModel> _box;
  const BookLocalDatasourceImplementation(this._box);

  @override
  ResultVoid createBook({required String title, required String description, required String author, required String createdAt}) {
    // TODO: implement createBook
    throw UnimplementedError();
  }

  @override
  ResultVoid deleteBook(String id) {
    // TODO: implement deleteBook
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<BookModel>> getBooks() {
    throw UnimplementedError();
  }

  @override
  ResultVoid updateBook({required String id, required BookModel book}) {
    // TODO: implement updateBook
    throw UnimplementedError();
  }
  
  
  
}