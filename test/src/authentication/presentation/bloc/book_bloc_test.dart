import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/core/errors/failure.dart';
import 'package:novels/src/authentication/domain/usecases/book/create_book.dart';
import 'package:novels/src/authentication/domain/usecases/book/get_books.dart';
import 'package:novels/src/authentication/presentation/bloc/book_bloc.dart';

class MockGettBooks extends Mock implements GetBooks {}

class MockCreateBook extends Mock implements CreateBook {}

void main() {
  late GetBooks getBooks;
  late CreateBook createBook;
  late BookBloc bloc;
  const tBook = BookParams.empty();
  const tFailure = Failure(statusCode: 400, message: "Server failed");
  setUp(() {
    getBooks = MockGettBooks();
    createBook = MockCreateBook();
    bloc = BookBloc(createBook: createBook, getBooks: getBooks);
    registerFallbackValue(tBook);
  });
  tearDown(() => bloc.close());
  test("initial state should be [BookInitial]", () {
    expect(bloc.state, BookInitial());
  });
  group("createBook", () {
    blocTest(
      "should emit [CreatingBook,BookCreated] when successful",
      build: () {
        when(
          () => createBook(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateBookEvent(
          title: tBook.title,
          description: tBook.description,
          author: tBook.author)),
      expect: () => const [CreatingBook(), BookCreated()],
      verify: (_) {
        verify(
          () => createBook(tBook),
        ).called(1);
        verifyNoMoreInteractions(createBook);
      },
    );

    blocTest(
      "should emit [CreatingBook,BookAuthError] when not successful",
      build: () {
        when(
          () => createBook(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateBookEvent(
          title: tBook.title,
          description: tBook.description,
          author: tBook.author)),
      expect: () => [const CreatingBook(), BookAuthError(tFailure.message)],
      verify: (_) {
        verify(
          () => createBook(tBook),
        ).called(1);
        verifyNoMoreInteractions(createBook);
      },
    );
  });

  group("getBooks", () {
    blocTest(
      "should emit [GettingBooks, BooksLoaded] when successful",
      build: () {
        when(
          () => getBooks(),
        ).thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetBooksEvent()),
      expect: () => const [GettingBooks(), BooksLoaded([])],
      verify: (_) {
        verify(
          () => getBooks(),
        ).called(1);
        verifyNoMoreInteractions(getBooks);
      },
    );

    blocTest("should emit [GettingBooks,BookAuthError] when not successful",
     build: (){
        when(() => getBooks(),).thenAnswer((_) async=> const Left(tFailure));
        return bloc;
     },
     act: (bloc) => bloc.add(const GetBooksEvent()),

     expect: () => [
      const GettingBooks(),
      BookAuthError(tFailure.message)
     ],

     verify: (_) {
       verify(() => getBooks(),).called(1);
       verifyNoMoreInteractions(getBooks);
     },
     );
  });
}
