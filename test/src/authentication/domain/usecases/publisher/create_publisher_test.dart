import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/src/authentication/data/repositories/publisher_repository_implimentation.dart';
import 'package:novels/src/authentication/domain/usecases/publisher/create_publisher.dart';
class MockPublisherRepo extends Mock implements PublisherRepositoryImplimentation{}
void main() {
  late PublisherRepositoryImplimentation repository;
  late CreatePublisher usecase;

  setUp((){
    repository=MockPublisherRepo();
    usecase=CreatePublisher(repository);
  });


  test("should call [repository.createPublisher] when the call is successful", ()async{
    const params=PublisherParams.emtpty();
    // Arrange
    when(() => repository.createPublisher(name: any(named: "name"), email: any(named: "email"), city: any(named: "city"), country: any(named: "country")),).thenAnswer((_) async=> const Right(null));

    // Act
    final result=await usecase.call(params);
    expect(result, equals(const Right<dynamic,void>(null)));
    verify(() => repository.createPublisher(name: "name", email: "email", city: "city", country: "country"),).called(1);
    verifyNoMoreInteractions(repository);
  });
}