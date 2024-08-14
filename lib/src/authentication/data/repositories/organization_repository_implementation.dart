import 'package:dartz/dartz.dart';
import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/errors/failure.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/data/datasources/organization_remote_datasource.dart';
import 'package:novels/src/authentication/domain/entities/organization.dart';
import 'package:novels/src/authentication/domain/repository/organization_repository.dart';

class OrganizationRepositoryImplementation implements OrganizationRepository{
  final OrganizationRemoteDataSourceImplimentation _datasource;
  const OrganizationRepositoryImplementation(this._datasource);
  @override
  ResultFutureVoid createOrganization({required String name, required String email, required String city, required String specialization}) async{
   try {
    await _datasource.createOrganization(name: name, email: email, city: city, specialization: specialization);
    return const Right(null);
   } on APIException catch (e) {
     return Left(APIFailure.fromException(e));
   }
  }

  @override
  ResultFuture<List<Organization>> getOrganizations() async{
   try {
      final response=await _datasource.getOrganizations();
    return Right(response);
   }on APIException catch (e) {
     return Left(APIFailure.fromException(e));
   }
  }

}