import 'package:mocktail/mocktail.dart';
import 'package:novels/core/errors/failure.dart';
import 'package:novels/src/authentication/domain/usecases/publisher/create_publisher.dart';
import 'package:novels/src/authentication/domain/usecases/publisher/get_publisher.dart';

class MockCreatePublisher extends Mock implements CreatePublisher {}

class MockGetPublisher extends Mock implements GetPublisher {}
  const tParams = PublisherParams.emtpty();
  const tFailure = Failure(statusCode: 400, message: "Oops! server failed");