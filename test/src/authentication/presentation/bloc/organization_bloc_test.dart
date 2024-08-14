import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/src/authentication/domain/usecases/organization/create_organization.dart';
import 'package:novels/src/authentication/domain/usecases/organization/get_organizations.dart';
import 'package:novels/src/authentication/presentation/bloc/organization_bloc.dart';

import '../organization_mock.dart';


void main() {
  late CreateOrganization createOrganization;
  late GetOrganizations getOrganizations;
  late OrganizationBloc bloc;


  setUp(() {
    createOrganization = MockCreateOrganization();
    getOrganizations = MockGetOrganizations();
    bloc = OrganizationBloc(
        createOrganization: createOrganization,
        getOrganizations: getOrganizations);
    registerFallbackValue(tParams);
  });

  tearDown(() => bloc.close());
  test("Initial state should be [OrganizationInitial]", () {
    expect(bloc.state, OrganizationInitial());
  });

  group("createOrganization", () {
    blocTest(
      "should emit [CreatingOrganizationState,OrganizationCreated] when successful",
      build: () {
        when(
          () => createOrganization(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) =>bloc.add(CreateOrganizationEvent( name: tParams.name,
          email: tParams.email,
          city: tParams.city,
          specialization: tParams.specialization)) ,
      expect: () =>
          const [CreatingOrganizationState(), OrganizationCreatedState()],
      verify: (_) {
        verify(
          () => createOrganization(tParams),
        ).called(1);
        verifyNoMoreInteractions(createOrganization);
      },
    );

    blocTest(
      "should emit [CreatingOrganizationState,OrganizationErrorState] when unsuccesful",
      build: () {
        when(() => createOrganization(any()))
            .thenAnswer((_) async => const Left(tFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateOrganizationEvent(
          name: tParams.name,
          email: tParams.email,
          city: tParams.city,
          specialization: tParams.specialization)),
      expect: () => [
        const CreatingOrganizationState(),
        OrganizationErrorState(tFailure.message)
      ],
      verify: (_) {
        verify(
          () => createOrganization(tParams),
        ).called(1);
        verifyNoMoreInteractions(createOrganization);
      },
    );
  });

  group("getOrganizations", () {
    blocTest(
      "should emit [GetOrganizationState,OrganizationLoaded] when successful",
      build: () {
        when(
          () => getOrganizations(),
        ).thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) =>bloc.add(const GetOrganizationEvent()),
      expect: () =>
          const [GetOrganizationState(), OrganizationsLoadedState([])],
      verify: (_) {
        verify(
          () => getOrganizations(),
        ).called(1);
        verifyNoMoreInteractions(getOrganizations);
      },
    );
    blocTest(
      "should emit [GetOrganizationState,OrganizationErrorState]",
      build: () {
        when(
          () => getOrganizations(),
        ).thenAnswer((_) async => const Left(tFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetOrganizationEvent()),
      expect: () => [
        const GetOrganizationState(),
        OrganizationErrorState(tFailure.message)
      ],
      verify: (_) {
        verify(
          () => getOrganizations(),
        ).called(1);
        verifyNoMoreInteractions(getOrganizations);
      },
    );
  });
}
