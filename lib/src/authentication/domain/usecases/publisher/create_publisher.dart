import 'package:equatable/equatable.dart';
import 'package:novels/core/usecase/usecase.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/repository/publisher_repository.dart';

class CreatePublisher extends UseCaseWithParams<void,PublisherParams>{
  const CreatePublisher(this._repository);

  final PublisherRepository _repository;
  @override
  ResultFuture<void> call(PublisherParams params)async=>_repository.createPublisher(name: params.name, email: params.email, city: params.city, country: params.country);

}

class PublisherParams extends Equatable{
  const PublisherParams({required this.name,required this.email,required this.city,required this.country});
  final String name;
  final String email;
  final String city;
  final String country;

  @override
  List<String> get props=>[name,email,city,country];

  const PublisherParams.emtpty():this(name: "name",email: "email",city: "city",country: "country");
}