import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:novel/core/constants/constants.dart';
import 'package:novel/core/errors/failure.dart';
import 'package:novel/core/utils/typedef.dart';
import 'package:novel/src/authentication/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();
  Future<void> createUser(
      {required String name,
      required String avatar,
      required String createdAt});

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint = "/test-api/users";
const kGetUsersEndpoint = "/test-api/users";

class AuthRemoteDataSourceImplementation extends AuthRemoteDataSource {
  final http.Client _client;
  const AuthRemoteDataSourceImplementation(this._client);

  @override
  Future<void> createUser(
      {required String name,
      required String avatar,
      required String createdAt}) async {
    try {
      final response = await _client.post(
          Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode(
              {"name": name, "avatar": avatar, "createdAt": createdAt}),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw {
          APIException(statusCode: response.statusCode, message: response.body)
        };
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw (APIException(statusCode: 505, message: e.toString()));
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response =
          await _client.get(Uri.https(kBaseUrl, kGetUsersEndpoint));
      if (response.statusCode != 200) {
        throw (APIException(
            message: response.body, statusCode: response.statusCode));
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw (APIException(message: e.toString(), statusCode: 505));
    }
  }
}
