import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/publisher.dart';

abstract class PublisherRepository{
   const PublisherRepository();
   ResultFutureVoid createPublisher({required String name,required String email, required String city, required String country});
   ResultFuture<List<Publisher>> getPublishers();
}