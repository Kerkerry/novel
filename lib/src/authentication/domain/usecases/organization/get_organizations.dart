import 'package:novels/core/usecase/usecase.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/organization.dart';
import 'package:novels/src/authentication/domain/repository/organization_repository.dart';

class GetOrganizations extends UseCaseWithoutParams<List<Organization>>{
  final OrganizationRepository _repository;
  const GetOrganizations(this._repository);
  @override
  ResultFuture<List<Organization>> call()async=>await _repository.getOrganizations();
  
}