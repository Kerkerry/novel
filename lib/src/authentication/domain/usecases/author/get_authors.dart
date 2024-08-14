import 'package:novels/core/usecase/usecase.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/author.dart';
import 'package:novels/src/authentication/domain/repository/author_repository.dart';

class GetAuthors extends UseCaseWithoutParams<List<Author>>{
   GetAuthors(this._repository);

  final AuthorRepository _repository;

  @override
  ResultFuture<List<Author>> call()async=>_repository.getAuthors();
}