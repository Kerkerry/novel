import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/organization.dart';

abstract class OrganizationRepository{
  const OrganizationRepository();
  
  ResultFutureVoid createOrganization({required String name,required String email,required String city,required String specialization});

  ResultFuture<List<Organization>> getOrganizations();
}