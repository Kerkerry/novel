import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/src/authentication/domain/repository/book_repository.dart';
import 'package:novels/src/authentication/domain/entities/book.dart';
import 'package:novels/src/authentication/domain/usecases/book/get_books.dart';
class MockBookRepository extends Mock implements BookRepository{}
void main() {
  late BookRepository repository;
  late GetBooks usecase;

  setUp((){
    repository=MockBookRepository();
    usecase=GetBooks(repository);
  });

  const books=[Book.empty()];
  test("should call [repo.getBooks] and return List<Book>", ()async{
    // Arrange
    when(() =>repository.getBooks() ,).thenAnswer((_) async=>const Right(books));
    // Act
    final result=await usecase();

    // Assert
    expect(result, equals(const Right<dynamic,List<Book>>(books)));
    verify(() => repository.getBooks()).called(1);
    verifyNoMoreInteractions(repository);
  });
}