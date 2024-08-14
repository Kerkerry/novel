import 'package:dartz/dartz.dart';
import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/errors/failure.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/data/datasources/book_remote_datasource.dart';
import 'package:novels/src/authentication/domain/entities/book.dart';
import 'package:novels/src/authentication/domain/repository/book_repository.dart';

class BookRepositoryImplementation implements BookRepository{
   BookRepositoryImplementation(this._remoteDatasource);

  BookRemoteDataSourceImplimentation _remoteDatasource;
  @override
  ResultFutureVoid createBook({required String title, required String description, required String author}) async{
    try {
      await _remoteDatasource.createBook(title: title, description: description, author: author);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Book>> getBooks()async {
    try {
      final response=await _remoteDatasource.getBooks();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
  
}