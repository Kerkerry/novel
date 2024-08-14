import 'package:novel/core/usecase/usecase.dart';
import 'package:novel/core/utils/typedef.dart';
import 'package:novel/src/authentication/domain/entities/user.dart';
import 'package:novel/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UseCaseWithoutParams<List<User>>{
  const GetUsers(this._repository);
  final AuthenticationRepository _repository;
  @override
  ResultFuture<List<User>> call() async=>_repository.getUsers();
}