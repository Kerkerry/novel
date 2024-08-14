import 'package:novels/core/usecase/usecase.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/publisher.dart';
import 'package:novels/src/authentication/domain/repository/publisher_repository.dart';

class GetPublisher extends UseCaseWithoutParams{
  final PublisherRepository _repository;
  const GetPublisher(this._repository);
  @override
  ResultFuture<List<Publisher>> call() async=>_repository.getPublishers();
}