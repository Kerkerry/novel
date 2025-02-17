
import 'package:novel/core/utils/typedef.dart';
import 'package:novel/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository{
  const AuthenticationRepository();

  ResultVoid createUser({required String name, required String createdAt,required String avatar});

  ResultFuture<List<User>> getUsers();
}