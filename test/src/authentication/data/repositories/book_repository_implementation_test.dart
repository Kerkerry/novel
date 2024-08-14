import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/errors/failure.dart';
import 'package:novels/src/authentication/data/datasources/book_remote_datasource.dart';
import 'package:novels/src/authentication/data/repositories/book_repository_implementation.dart';
import 'package:novels/src/authentication/domain/entities/book.dart';
import 'package:novels/src/authentication/domain/repository/book_repository.dart';
class MockBookRemoteDatasource extends Mock implements BookRemoteDataSourceImplimentation{}

void main() {
  late BookRepository repository;
  late BookRemoteDataSourceImplimentation remoteDatasource;

  setUp(() {
    remoteDatasource=MockBookRemoteDatasource();
    repository=BookRepositoryImplementation(remoteDatasource);
  });

    const String title="title";
    const String description="description";
    const String author="author";
    const tException=APIException(message: "Failed to make the request", statusCode:500);
  group("createBook", () {
    test("should call [remoteDatasource.createBook] and complete successful when the call to the remoteDatasource is successful", ()async{
      when(() => remoteDatasource.createBook(title: any(named: "title"), description: any(named:"description"), author: any(named:"author")),).thenAnswer((_) async=>Future.value() );

      final response=await repository.createBook(title: title, description: description, author: author);

      expect(response, equals(const Right(null)));
      verify(() => remoteDatasource.createBook(title: title, description: description, author: author),).called(1);
      verifyNoMoreInteractions(remoteDatasource);
    });

    test("should call [APIFailure] when the call to the remoteDatasource is unsuccesful", () async{
      const tException=APIException(statusCode: 500, message: "Unkown error occured");
      when(() => remoteDatasource.createBook(title: any(named: "title"), description: any(named:"description"), author: any(named:"author")),).thenThrow(tException);

      final response=await repository.createBook(title: title, description: description, author: author);

      expect(response, equals(Left(APIFailure(statusCode: tException.statusCode, message: tException.message))));
      verify(() => remoteDatasource.createBook(title: title, description: description, author: author),);
      verifyNoMoreInteractions(remoteDatasource);
    });
   });


   group("getUsers", () { 
    test("should return [List<Book>] when the call to the remote data sources is successful", () async{
      when(() => remoteDatasource.getBooks(),).thenAnswer((_) async=> []);

      final result=await repository.getBooks();

      expect(result, isA<Right<dynamic,List<Book>>>());
      verify(() => remoteDatasource.getBooks(),).called(1);
      verifyNoMoreInteractions(remoteDatasource);
    });

    test("should throw [APIFailure] if the call to the remote datasource is not successful", () async{
      when(() => remoteDatasource.getBooks(),).thenThrow(tException);

      final result=await repository.getBooks();

      expect(result, equals(Left(APIFailure(statusCode: tException.statusCode, message:tException. message))));
      verify(() => remoteDatasource.getBooks(),).called(1);
      verifyNoMoreInteractions(remoteDatasource);
    });
   });
}