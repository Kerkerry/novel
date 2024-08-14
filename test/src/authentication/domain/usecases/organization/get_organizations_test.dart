import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/src/authentication/data/repositories/organization_repository_implementation.dart';
import 'package:novels/src/authentication/domain/entities/organization.dart';
import 'package:novels/src/authentication/domain/usecases/organization/get_organizations.dart';

import '../../common/org_mock.dart';

void main() {
  late OrganizationRepositoryImplementation repository;
  late GetOrganizations usecase;
  setUp(() {
      repository=MockOrgRepo();
      usecase=GetOrganizations(repository);
  });
  const tOrgs=[Organization.empty()];
  test("should call [repository.getOrganizations] when the call is successful", ()async {
    // Arrange
    when(()=>repository.getOrganizations()).thenAnswer((_) async=> const Right(tOrgs));
    // Act
    final result=await usecase.call();
    // assert
    expect(result, equals(const Right<dynamic,List<Organization>>(tOrgs)));
    verify(() => repository.getOrganizations(),).called(1);
    verifyNoMoreInteractions(repository);
  });
}