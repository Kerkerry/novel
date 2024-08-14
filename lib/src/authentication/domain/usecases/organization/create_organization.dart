import 'package:equatable/equatable.dart';
import 'package:novels/core/usecase/usecase.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/repository/organization_repository.dart';

class CreateOrganization extends UseCaseWithParams<void, OrganizationParams> {
  final OrganizationRepository _repository;
  const CreateOrganization(this._repository);

  @override
  ResultFuture<void> call(OrganizationParams params) async =>await
      _repository.createOrganization(
          name: params.name,
          email: params.email,
          city: params.city,
          specialization: params.specialization);
}

class OrganizationParams extends Equatable {
  const OrganizationParams(
      {required this.name,
      required this.email,
      required this.city,
      required this.specialization});

  final String name;
  final String email;
  final String city;
  final String specialization;

  @override
  List<Object?> get props => [name, email, city, specialization];

  const OrganizationParams.empty()
      : this(
            name: "name",
            email: "email",
            city: "city",
            specialization: "specialization");
}
