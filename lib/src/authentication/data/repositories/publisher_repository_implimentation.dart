import 'package:dartz/dartz.dart';
import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/errors/failure.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/data/datasources/publisher_remote_datasource.dart';
import 'package:novels/src/authentication/domain/entities/publisher.dart';
import 'package:novels/src/authentication/domain/repository/publisher_repository.dart';

class PublisherRepositoryImplimentation implements PublisherRepository{
  const PublisherRepositoryImplimentation(this._dataSource);
  final PublisherRemoteDatasourceImplementation _dataSource;
  @override
  ResultFutureVoid createPublisher({required String name, required String email, required String city, required String country}) async{
    try {
      await _dataSource.createPublisher(name: name, email: email, city: city, country: country);
    return const Right(null);
    }on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Publisher>> getPublishers() async{
    try {
      final response=await _dataSource.getPublishers();
    return Right(response);
    }on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}