import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/errors/failure.dart';
import 'package:novels/src/authentication/data/datasources/publisher_remote_datasource.dart';
import 'package:novels/src/authentication/data/repositories/publisher_repository_implimentation.dart';
import 'package:novels/src/authentication/domain/entities/publisher.dart';
import 'package:novels/src/authentication/domain/repository/publisher_repository.dart';
class MockPublisherDataSourceImpl extends Mock implements PublisherRemoteDatasourceImplementation{}
void main() {
  late PublisherRepository repository;
  late PublisherRemoteDatasourceImplementation datasource;

  setUp((){
    datasource=MockPublisherDataSourceImpl();
    repository=PublisherRepositoryImplimentation(datasource);
  });
  const String name="name";
  const String email="email";
  const String city="city";
  const String country="country";
  const tException=APIException(statusCode: 500, message: "Server failure");
  group("createPublisher", () {
    test("should call [datasource.createPublisher] when the call to the remote datasource is successful and complete succeful", ()async{
      // Arrange
      when(()=> datasource.createPublisher(name: any(named: "name"), email: any(named: "email"), city: any(named: "city"), country: any(named: "country"))).thenAnswer((invocation) async=> Future.value());
      // act
      final result=await repository.createPublisher(name: name, email: email, city: city, country: country);
      // assert
      expect(result, equals(const Right<dynamic,void>(null)));
      verify(() => datasource.createPublisher(name: name, email: email, city: city, country: country),).called(1);
      verifyNoMoreInteractions(datasource);
    });

    test("should throw [APIFailure] when the call to the remote datasource is not successful", ()async{
      when(()=>datasource.createPublisher(name: any(named: "name"), email: any(named: "email"), city: any(named: "city"), country: any(named: "country"))).thenThrow(tException);

      final result=await repository.createPublisher(name: name, email: email, city: city, country: country);

      expect(result, equals(Left(APIFailure(message: tException.message,statusCode: tException.statusCode))));
      verify(() => datasource.createPublisher(name: name, email: email, city: city, country: country),).called(1);
      verifyNoMoreInteractions(datasource);
    });
  });

  group("getPublishers", () {
    test("should return [List<Publisher>] whe the call to the remote data source is successful", () async{
      when(()=>datasource.getPublishers()).thenAnswer((_) async=> []);

      final result=await repository.getPublishers();

      expect(result, isA<Right<dynamic,List<Publisher>>>());
      verify(() => datasource.getPublishers(),).called(1);
      verifyNoMoreInteractions(datasource);
    });

    test("should throw [APIFailure] when the call to the remote data source is unsuccessful", () async{
      // Arrnge
      when(() => datasource.getPublishers(),).thenThrow(tException);

    // Act
    final result=await repository.getPublishers();

    // assert
    expect(result, equals(Left<Failure,dynamic>(APIFailure(message: tException.message,statusCode: tException.statusCode))));
    verify(() => datasource.getPublishers(),).called(1);
    verifyNoMoreInteractions(datasource);
    });
   });
   
}