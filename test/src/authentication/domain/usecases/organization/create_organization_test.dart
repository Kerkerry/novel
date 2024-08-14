import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/src/authentication/data/repositories/organization_repository_implementation.dart';
import 'package:novels/src/authentication/domain/usecases/organization/create_organization.dart';

import '../../common/org_mock.dart';


void main() {
  late OrganizationRepositoryImplementation repository;
  late CreateOrganization usecase;
  setUp(() {
    repository=MockOrgRepo();
    usecase=CreateOrganization(repository);
  });

  test("should call [repositpry.createOrganization] when the call is successful", ()async{
    // arrange
    const params=OrganizationParams.empty();
    when(() => repository.createOrganization(name: any(named: "name"), email: any(named: "email"), city: any(named: "city"), specialization: any(named: "specialization")),).thenAnswer((_)async => const Right(null));

    // Act
    final result=await usecase.call(params);

    // Assert
    expect(result, equals(const Right<dynamic,void>(null)));
    verify(() => repository.createOrganization(name: "name", email: "email", city: "city", specialization: "specialization"),).called(1);
    verifyNoMoreInteractions(repository);
  });
}