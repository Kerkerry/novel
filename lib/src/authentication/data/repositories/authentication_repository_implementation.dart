import 'package:dartz/dartz.dart';
import 'package:novel/core/errors/failure.dart';
import 'package:novel/src/authentication/data/datasource/remote/auth_remote_datasource.dart';
import 'package:novel/src/authentication/domain/entities/user.dart';
import 'package:novel/src/authentication/domain/repositories/authentication_repository.dart';

class AuthRepoImplementation extends AuthenticationRepository{
  const AuthRepoImplementation(this._remoteDataSource);
  final AuthRemoteDataSource _remoteDataSource;
  @override
  Future<Either<Failure, void>> createUser({required String name, required String createdAt, required String avatar}) async{
    try {
      await _remoteDataSource.createUser(name: name, avatar: avatar, createdAt: createdAt);
      return const Right(null);
    }on APIException catch (e) {
      return Left(ApiFailure(statusCode: e.statusCode, message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getUsers() async{
    try {
     final results=await _remoteDataSource.getUsers();
     return Right(results); 
    }on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
  
}