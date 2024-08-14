import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/errors/failure.dart';
import 'package:novels/src/authentication/data/datasources/organization_remote_datasource.dart';
import 'package:novels/src/authentication/data/repositories/organization_repository_implementation.dart';
import 'package:novels/src/authentication/domain/entities/organization.dart';
import 'package:novels/src/authentication/domain/repository/organization_repository.dart';
class MockOrgRemoteDataSource extends Mock implements OrganizationRemoteDataSourceImplimentation{}
void main() {
  late OrganizationRemoteDataSourceImplimentation dataSource;
  late OrganizationRepository repository;

  setUp((){
    dataSource=MockOrgRemoteDataSource();
    repository=OrganizationRepositoryImplementation(dataSource);
  });
  const tException=APIException(message: "Server failure, come back after 1 hour",statusCode: 500);
  group("createOrganization", () { 
    const name="name";
    const email="email";
    const city="city";
    const specialization="specialization";
    test("should call [datasource.createOrganization] when the call to the data source is successful", () async{
      // arrange
      when(() => dataSource.createOrganization(name: any(named: "name"), email: any(named: "email"), city: any(named: "city"), specialization: any(named:"specialization")),).thenAnswer((_) async=> Future.value());
      // Act
      final result=await repository.createOrganization(name: name, email: email, city: city, specialization: specialization);

      // Assert
      expect(result, equals(const Right<dynamic,void>(null)));
      verify(()=>dataSource.createOrganization(name: name, email: email, city: city, specialization: specialization)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
    test("should throw [APIFailure] when the call to datasource is not successful", ()async{
      // arrange
      when(() => dataSource.createOrganization(name: any(named: "name"), email: any(named: "email"), city: any(named: "city"), specialization: any(named: "specialization")),).thenThrow(tException);
      // act
      final result=await repository.createOrganization(name: name, email: email, city: city, specialization: specialization);

      // assert
      expect(result, equals(Left(APIFailure(statusCode: tException.statusCode, message: tException.message))));
      verify(() => dataSource.createOrganization(name: name, email: email, city: city, specialization: specialization),).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });

  group("getOrganizations", () { 
    test("should return [List<OrganizationModel>] when the call to the data source is successful", () async{
      // Arrange
      when(() => dataSource.getOrganizations(),).thenAnswer((_) async=> []);
      // Act
      final result=await repository.getOrganizations();
      // assert
      expect(result, isA<Right<dynamic,List<Organization>>>());
      verify(() => dataSource.getOrganizations(),).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test("should throw [APIFailure] when the call to data source is not successful", ()async{
      // Arrange
      when(() => dataSource.getOrganizations(),).thenThrow(tException);
      // Act
      final result = await repository.getOrganizations();
      // assert
      expect(result, equals(Left(APIFailure(message: tException.message,statusCode: tException.statusCode))));
      verify(() => dataSource.getOrganizations(),).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}