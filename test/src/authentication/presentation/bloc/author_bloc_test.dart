import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/src/authentication/domain/usecases/author/create_author.dart';
import 'package:novels/src/authentication/domain/usecases/author/get_authors.dart';
import 'package:novels/src/authentication/presentation/bloc/author_bloc.dart';

import '../author_mock.dart';

void main() {
  late CreateAuthor createAuthor;
  late GetAuthors getAuthors;
  late AuthorBloc bloc;
  setUp(() {
    createAuthor = MockCreateAuthor();
    getAuthors = MockGetAuthors();
    bloc = AuthorBloc(createAuthor: createAuthor, getAuthors: getAuthors);
    registerFallbackValue(tParams);
  });
  tearDown(() => bloc.close());
  test("Initial state should be [AuthorInitial]", () {
    expect(bloc.state, AuthorInitial());
  });

  group("createAuthor", () {
    blocTest(
      "should emit [CreatingAuthor,AuthorCreatedState] when successful",
      build: () {
        when(() => createAuthor(any()))
            .thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateAuthorEvent(
          name: tParams.name, email: tParams.email, book: tParams.book)),
      expect: () => const [CreatingAuthor(), AuthorCreatedState()],
      verify: (_) {
        verify(
          () => createAuthor(tParams),
        ).called(1);
        verifyNoMoreInteractions(createAuthor);
      },
    );

    blocTest(
      "should emit [CreatingAuthor, AuthorErrorState] when unsuccessful",
      build: () {
        when(
          () => createAuthor(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateAuthorEvent(
          name: tParams.name, email: tParams.email, book: tParams.book)),
      expect: () => [const CreatingAuthor(), AuthorError(tFailure.message)],
      verify: (bloc) {
        verify(
          () => createAuthor(tParams),
        ).called(1);
        verifyNoMoreInteractions(createAuthor);
      },
    );
  });

  group("getAuthors", () {
    blocTest(
      "should emit [GetAuthorsState, AuthorsLoaded] when successful",
      build: () {
        when(
          () => getAuthors(),
        ).thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetAuthorsEvent()),
      expect: () => const [GetAuthorsState(), AuthorsLoaded([])],
      verify: (bloc) {
        verify(
          () => getAuthors(),
        ).called(1);
        verifyNoMoreInteractions(getAuthors);
      },
    );

    blocTest(
      "should emit [GetAuthorsState,AuthorError]",
      build: () {
        when(
          () => getAuthors(),
        ).thenAnswer((_) async => const Left(tFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetAuthorsEvent()),
      expect: () => [const GetAuthorsState(), AuthorError(tFailure.message)],
      verify: (bloc) {
        verify(
          () => getAuthors(),
        ).called(1);
        verifyNoMoreInteractions(getAuthors);
      },
    );
  });
}
