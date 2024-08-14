import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/src/authentication/data/repositories/author_repository_implementation.dart';
import 'package:novels/src/authentication/domain/entities/author.dart';
import 'package:novels/src/authentication/domain/usecases/author/get_authors.dart';

class MockAuthorRepo extends Mock implements AuthorRepositoryimplementation{}
void main() {
  late AuthorRepositoryimplementation repository;
  late GetAuthors usecase;

  setUp((){
    repository=MockAuthorRepo();
    usecase=GetAuthors(repository);
  });

  final tAuthors=[Author.empty()];
  test("should return [List<AuthorModel>] when the call is successful", ()async {
    // Arrange
    when(() => repository.getAuthors(),).thenAnswer((_) async=> Right(tAuthors));
    // Act
    final result=await usecase.call();
    // Assert
    expect(result, equals(Right<dynamic,List<Author>>(tAuthors)));
    verify(() => repository.getAuthors(),).called(1);
    verifyNoMoreInteractions(repository);
  });
}