

import 'package:equatable/equatable.dart';
import 'package:novel/core/usecase/usecase.dart';
import 'package:novel/core/utils/typedef.dart';
import 'package:novel/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams>{
  const CreateUser(this._repository);
  final AuthenticationRepository _repository;
  
  @override
  ResultVoid call(CreateUserParams params)async=>_repository.createUser(name: params.name, createdAt: params.createdAt, avatar: params.avatar);


}

class CreateUserParams extends Equatable{
  final String name;
  final String avatar;
  final String createdAt;

  const CreateUserParams({required this.name, required this.avatar, required this.createdAt});

  @override
  List<String> get props=>[name,avatar,createdAt];


  const CreateUserParams.empty():this(name: "name",avatar: "avatar",createdAt: "createdAt"); 
}