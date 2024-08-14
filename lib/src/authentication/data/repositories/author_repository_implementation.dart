import 'package:dartz/dartz.dart';
import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/errors/failure.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/data/datasources/author_remote_datasource.dart';
import 'package:novels/src/authentication/domain/entities/author.dart';
import 'package:novels/src/authentication/domain/repository/author_repository.dart';

class AuthorRepositoryimplementation extends AuthorRepository{
   AuthorRepositoryimplementation(this._remoteDataSource);

  AuthorRemoteDataSourceImplementation _remoteDataSource;
  @override
  ResultFutureVoid createAuthor({required String name, required String email, required String book})async {
    try {
      await _remoteDataSource.createAuthor(name: name, email: email, book: book);
      return const Right(null);
    }on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Author>> getAuthors()async {
   try {
     final response=await _remoteDataSource.getAuthors();
    return  Right(response);
   } on APIException catch (e) {
     return Left(APIFailure.fromException(e));
   }
  }

}