import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:novels/src/authentication/data/repositories/publisher_repository_implimentation.dart';
import 'package:novels/src/authentication/domain/entities/publisher.dart';
import 'package:novels/src/authentication/domain/usecases/publisher/get_publisher.dart';
class MockPublisherRepo extends Mock implements PublisherRepositoryImplimentation{}
void main() {
  late PublisherRepositoryImplimentation repository;
  late GetPublisher usecase;

  setUp((){
    repository=MockPublisherRepo();
    usecase=GetPublisher(repository);
  });
  test("should call [repository.getPublishers] when the call is success", () async{
    const tPubs=[Publisher.empty()];
    // Arrange
    when(() => repository.getPublishers(),).thenAnswer((_) async=>const Right(tPubs));

    // Act 
    final result=await usecase.call();

    // assert
    expect(result, equals(const Right<dynamic, List<Publisher>>(tPubs)));
    verify(() => repository.getPublishers(),).called(1);
    verifyNoMoreInteractions(repository);
  });
}