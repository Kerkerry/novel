import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/src/authentication/domain/repository/book_repository.dart';
import 'package:novels/src/authentication/domain/usecases/book/create_book.dart';

class MockBookRepository extends Mock implements BookRepository{}
void main() {
  late BookRepository repository;
  late CreateBook usecase;

  const params=BookParams.empty();
  setUp((){
    repository=MockBookRepository();
    usecase=CreateBook(repository);
  });

  test("Should call [Repo.createBook]", ()async{
    // arrange
    when(() =>repository.createBook(title: any(named: 'title'), description:any(named:'description'), author:any(named: 'author')) ,).thenAnswer((_) async=> const Right(null));
    // Act
    final result=await usecase(params);

    // Assert
    expect(result, equals(const Right<dynamic,void>(null)));
    verify(() => repository.createBook(title: "title", description: "description", author: "author"),).called(1);
    verifyNoMoreInteractions(repository);
  });
}