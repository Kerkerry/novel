import 'package:equatable/equatable.dart';
import 'package:novels/core/usecase/usecase.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/repository/author_repository.dart';

class CreateAuthor extends UseCaseWithParams<void,AuthorParams>{
   CreateAuthor(this._repository);

  AuthorRepository _repository;
  @override
  ResultFuture call(AuthorParams params)async=>_repository.createAuthor(name: params.name, email: params.email, book: params.book);
    
}

class AuthorParams extends Equatable{
  const AuthorParams({required this.name, required this.email,required this.book});
  final String name;
  final String email;
  final String book;

  @override
  List<String> get props=>[name,email,book];

  const AuthorParams.empty():this(name: "name",email: "email",book: "book");
}