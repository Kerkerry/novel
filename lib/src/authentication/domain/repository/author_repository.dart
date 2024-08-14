import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/author.dart';

abstract class AuthorRepository{
  const AuthorRepository();

  ResultFutureVoid createAuthor({required String name,required String email,required String book});
  ResultFuture<List<Author>> getAuthors();
}