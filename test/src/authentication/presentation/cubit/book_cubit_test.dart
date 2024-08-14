import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/src/authentication/domain/usecases/book/create_book.dart';
import 'package:novels/src/authentication/domain/usecases/book/get_books.dart';
import 'package:novels/src/authentication/presentation/cubit/book_cubit.dart';
import '../book_mock.dart';



void main() {
  late CreateBook createBook;
  late GetBooks getBooks;
  late BookCubit cubit;
 
  setUp(() {
    createBook = MockCreateBook();
    getBooks = MockGetBooks();
    cubit = BookCubit(getBooks: getBooks, createBook: createBook);
    registerFallbackValue(tParams);
  });
  tearDown(() => cubit.close());
  test("initial state should be [BookInitial]", () {
    expect(cubit.state, BookInitial());
  });

  group("createBook", () {
    blocTest(
      "should emit [CreatingBook,BookCreated] when successful",
      build: () {
        when(
          () => createBook(any()),
        ).thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.createBook(
          title: tParams.title,
          description: tParams.description,
          author: tParams.author),
      expect: () => [const CreatingBook(), const BookCreated()],
      verify: (_) {
        verify(
          () => createBook(tParams),
        ).called(1);
        verifyNoMoreInteractions(createBook);
      },
    );

    blocTest(
      "should emit [CreatingBook,BookAuthError] when unsuccessful",
      build: () {
        when(
          () => createBook(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.createBook(
          title: tParams.title,
          description: tParams.description,
          author: tParams.author),
      expect: () => [const CreatingBook(), BookAuthError(tFailure.message)],
      verify: (_) {
        verify(
          () => createBook(tParams),
        ).called(1);
        verifyNoMoreInteractions(createBook);
      },
    );
  });

  group("getBooks", () {
    blocTest(
      "should emit [GettingBooks,BooksLoaded] when successful",
      build: () {
        when(
          () => getBooks(),
        ).thenAnswer((_) async => const Right([]));
        return cubit;
      },
      act: (cubit) => cubit.getBooks(),
      expect: () => const [GettingBooks(), BooksLoaded([])],
      verify: (_) {
        verify(() => getBooks()).called(1);
        verifyNoMoreInteractions(getBooks);
      },
    );
    blocTest("should emit [GettingBooks, BookAuthError] when unsuccessful", 
    build: (){
      when(() => getBooks(),).thenAnswer((_)async => const Left(tFailure));
      return cubit;
    },
    act: (cubit) =>cubit.getBooks(),

    expect: () => [
      const GettingBooks(),
      BookAuthError(tFailure.message)
    ],
    verify: (bloc) {
      verify(() => getBooks(),).called(1);
      verifyNoMoreInteractions(getBooks);
    },
    );
  });
}
