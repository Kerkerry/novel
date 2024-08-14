import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/errors/failure.dart';
import 'package:novels/src/authentication/data/datasources/author_remote_datasource.dart';
import 'package:novels/src/authentication/data/repositories/author_repository_implementation.dart';
import 'package:novels/src/authentication/domain/entities/author.dart';
import 'package:novels/src/authentication/domain/repository/author_repository.dart';
class MockAuthorRemoteImpl extends Mock implements AuthorRemoteDataSourceImplementation{

  
}
void main() {
 late AuthorRemoteDataSourceImplementation remoteDataSource;
 late AuthorRepository repository;

 setUp((){
  remoteDataSource=MockAuthorRemoteImpl();
  repository=AuthorRepositoryimplementation(remoteDataSource);
});

const String name="name";
const String email="email";
const String book="book";
const tException=APIException(statusCode: 500, message: "Server failed, come back later");
group("createAuthor", () {
  test("should call [remoteDataSource.createAuthor] and complete successfully when the call to the data sources is successful", ()async{
    // arrange
    when(() => remoteDataSource.createAuthor(name: any(named: "name"), email: any(named:"email"), book: any(named: "book")),).thenAnswer((_) async => Future.value);
    // act
    final response=await repository.createAuthor(name: name, email: email, book: book);
    // Assert
    expect(response, equals(const Right<dynamic,void>(null)));
    verify(() => remoteDataSource.createAuthor(name: name, email: email, book: book),).called(1);
    verifyNoMoreInteractions(remoteDataSource);
  });

  test("should throw [APIFailure] when the call to the  datasource is not successful", ()async {
    when(() =>remoteDataSource.createAuthor(name: any(named: "name"), email: any(named:"email"), book: any(named: "book")) ).thenThrow(tException);

    final response=await repository.createAuthor(name: name, email: email, book: book);

    expect(response, equals(Left(APIFailure(statusCode:tException.statusCode, message:tException.message))));
    verify(() => remoteDataSource.createAuthor(name: name, email: email, book: book),).called(1);
    verifyNoMoreInteractions(remoteDataSource);
  });
 });


  group("getAuthors", () { 
    test("should return [List<Author>] when the call to the  datasource is successful", ()async{
      // Arrange
      when(() => remoteDataSource.getAuthors(),).thenAnswer((_) async=> []);
      // Act
      final result=await repository.getAuthors();
      // Assert
      expect(result, isA<Right<dynamic,List<Author>>>());
      verify(() => remoteDataSource.getAuthors(),).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test("should throw [APIFailure] when the call to the datasource is not successful", () async{
      when(() => remoteDataSource.getAuthors(),).thenThrow(tException);
      final result=await repository.getAuthors();
      expect(result, equals(Left<Failure,dynamic>(APIFailure(statusCode:tException.statusCode, message:tException.message))));
      verify(() => remoteDataSource.getAuthors(),).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

}