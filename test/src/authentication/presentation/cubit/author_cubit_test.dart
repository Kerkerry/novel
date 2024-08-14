import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/src/authentication/domain/usecases/author/create_author.dart';
import 'package:novels/src/authentication/domain/usecases/author/get_authors.dart';
import 'package:novels/src/authentication/presentation/cubit/author_cubit.dart';

import '../author_mock.dart';



void main() {
  late CreateAuthor createAuthor;
  late GetAuthors getAuthors;
  late AuthorCubit cubit;
  setUp(() {
    createAuthor = MockCreateAuthor();
    getAuthors = MockGetAuthors();
    cubit = AuthorCubit(createAuthor: createAuthor, getAuthors: getAuthors);
    registerFallbackValue(tParams);
  });
  tearDown(() => cubit.close());
  test("Initial state should be [AuthorInitial]", () {
    expect(cubit.state, AuthorInitial());
  });

  group("createAuthor", () {
    blocTest(
      "should emit [CreatingAuthor,AuthorCreated] when successful",
      build: () {
        when(
          () => createAuthor(any()),
        ).thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.createAuthor(
          name: tParams.name, email: tParams.email, book: tParams.book),
      expect: () => const [CreatingAuthor(), AuthorCreatedState()],
      verify: (_) {
        verify(
          () => createAuthor(tParams),
        ).called(1);
        verifyNoMoreInteractions(createAuthor);
      },
    );

    blocTest(
      "should emit [CreatingAuthor,AuthorError] when unsuccessful",
      build: () {
        when(
          () => createAuthor(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.createAuthor(
          name: tParams.name, email: tParams.email, book: tParams.book),
      expect: () => [const CreatingAuthor(), AuthorError(tFailure.message)],
      verify: (_) {
        verify(
          () => createAuthor(tParams),
        ).called(1);
        verifyNoMoreInteractions(createAuthor);
      },
    );
  });

  group("getAuthors", () {
    blocTest(
      "should emit [GetAuthorsState,AuthorsLoaded] when successful",
      build: () {
        when(
          () => getAuthors(),
        ).thenAnswer((_) async => const Right([]));
        return cubit;
      },
      act: (cubit) => cubit.getAuthors(),
      expect: () => const [GetAuthorsState(), AuthorsLoaded([])],
      verify: (_) {
        verify(
          () => getAuthors(),
        ).called(1);
        verifyNoMoreInteractions(getAuthors);
      },
    );

    blocTest("should emit [GetAuthorsState,AuthorError] when unsuccessful", 
    build: (){
      when(() => getAuthors(),).thenAnswer((_)async => const Left(tFailure));
      return cubit;
    },
    act: (cubit) =>cubit.getAuthors(),

    expect: () => [
      const GetAuthorsState(),
      AuthorError(tFailure.message)
    ],
    verify: (_) {
      verify(() => getAuthors(),).called(1);
      verifyNoMoreInteractions(getAuthors);
    },
    );
  });
}
