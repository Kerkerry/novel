import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:novels/src/authentication/domain/usecases/publisher/create_publisher.dart';
import 'package:novels/src/authentication/domain/usecases/publisher/get_publisher.dart';
import 'package:novels/src/authentication/presentation/cubit/publisher_cubit.dart';

import '../publisher_mock.dart';



void main() {
  late CreatePublisher createPublisher;
  late GetPublisher getPublisher;
  late PublisherCubit cubit;


  setUp(() {
    createPublisher = MockCreatePublisher();
    getPublisher = MockGetPublisher();
    cubit = PublisherCubit(
        createPublisher: createPublisher, getPublisher: getPublisher);
    registerFallbackValue(tParams);
  });

  tearDown(() => cubit.close());
  
  test("Initial state should be [PublisherInitial]", () {
    expect(cubit.state, PublisherInitial());
  });

  group("createPublisher", () {
    blocTest(
      "should emit [CreatingPublisherState, PublisherCreatedState] when successful",
      build: () {
        when(
          () => createPublisher(any()),
        ).thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.createPublisher(
          name: tParams.name,
          email: tParams.email,
          city: tParams.city,
          country: tParams.country),
      expect: () => const [CreatingPublisherState(), PublisherCreatedState()],
      verify: (_) {
        verify(
          () => createPublisher(tParams),
        ).called(1);
        verifyNoMoreInteractions(createPublisher);
      },
    );

    blocTest(
      "should emit [CreatingPublisherState,PublihserErrorState] when unsuccessful",
      build: () {
        when(
          () => createPublisher(any()),
        ).thenAnswer((_) async => const Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.createPublisher(
          name: tParams.name,
          email: tParams.email,
          city: tParams.city,
          country: tParams.country),
      expect: () => [
        const CreatingPublisherState(),
        PublisherErrorState(tFailure.message)
      ],
      verify: (_) {
        verify(
          () => createPublisher(tParams),
        ).called(1);
        verifyNoMoreInteractions(createPublisher);
      },
    );
  });

  group("getPublishers", () {
    blocTest(
      "should emit [GetPublisherState, PublisherLoaded] when successful",
      build: () {
        when(
          () => getPublisher(),
        ).thenAnswer((_) async => const Right([]));
        return cubit;
      },
      act: (cubit) => cubit.getPublisher(),
      expect: () => const [GetPublisherState(), PublisherLoadedState([])],
      verify: (_) {
        verify(
          () => getPublisher(),
        ).called(1);
        verifyNoMoreInteractions(getPublisher);
      },
    );

    blocTest(
      "should emit [GetPublisherState,PublihserErrorState] when unsuccessful",
      build: () {
        when(
          () => getPublisher(),
        ).thenAnswer((_) async => const Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.getPublisher(),
      expect: () =>
          [const GetPublisherState(), PublisherErrorState(tFailure.message)],
      verify: (_) {
        verify(
          () => getPublisher(),
        ).called(1);
        verifyNoMoreInteractions(getPublisher);
      },
    );
  });
}
