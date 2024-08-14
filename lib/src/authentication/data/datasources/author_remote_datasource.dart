import 'dart:convert';

import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/utils/constants.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/data/models/author_model.dart';
import 'package:http/http.dart' as http;
abstract class AuthorRemoteDataSource{
  const AuthorRemoteDataSource();

  Future<void> createAuthor({
    required String name,required String email,required String book
  });
  Future<List<AuthorModel>> getAuthors();
}

const kCreateAuthorEndpoint="/test_api/author";
const kGetAuthorsEndpoint="/test_api/author";

class AuthorRemoteDataSourceImplementation implements AuthorRemoteDataSource{
  final http.Client _client;
  const AuthorRemoteDataSourceImplementation(this._client);

  @override
  Future<void> createAuthor({required String name, required String email, required String book})async {
    final response=await _client.post(Uri.https(kBaseUrl,kCreateAuthorEndpoint),body: jsonEncode({"name":name,"email":email,"book":book}));
    if(response.statusCode!=200 && response.statusCode!=201){
      throw APIException(statusCode: response.statusCode, message: response.body);
    }
  }

  @override
  Future<List<AuthorModel>> getAuthors() async{
    try {
      final response=await _client.get(Uri.https(kBaseUrl,kGetAuthorsEndpoint));
      if(response.statusCode!=200){
        throw APIException(statusCode: response.statusCode, message: response.body);
      }
      return List<DataMap>.from(jsonDecode(response.body) as List).map((author) => AuthorModel.fromMap(author)).toList();
    } 
    on APIException {
      rethrow;
    }
    catch (e) {
      throw APIException(statusCode: 505, message: e.toString());
    }
  }

}