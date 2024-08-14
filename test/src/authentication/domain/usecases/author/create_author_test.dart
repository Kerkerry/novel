import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/src/authentication/data/repositories/author_repository_implementation.dart';
import 'package:novels/src/authentication/domain/usecases/author/create_author.dart';
class MockAuthorRepo extends Mock implements AuthorRepositoryimplementation{}
void main() {
  late AuthorRepositoryimplementation repository;
  late CreateAuthor usecase;

  const params=AuthorParams.empty();
  setUp((){
    repository=MockAuthorRepo();
    usecase =CreateAuthor(repository);
  });
  test("should call [repository.CreateAuthor]", () async{
    // Arrange
    when(() => repository.createAuthor(name: any(named: "name"), email: any(named: "email"), book: any(named: "book")),).thenAnswer((_) async=> const Right(null));
    // act
    final result=await usecase.call(params);

    // Assert
    expect(result, equals(const Right<dynamic,void>(null)));
    verify(() => repository.createAuthor(name: "name", email: "email", book: "book"),).called(1);
    verifyNoMoreInteractions(repository);
  });
}