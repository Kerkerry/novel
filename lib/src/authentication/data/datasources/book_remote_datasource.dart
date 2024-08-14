import 'dart:convert';
import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/utils/constants.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/data/models/book_model.dart';
import 'package:http/http.dart' as http;

abstract class BookRemoteDataSource {
  const BookRemoteDataSource();
  Future<void> createBook(
      {required String title,
      required String description,
      required String author});
  Future<List<BookModel>> getBooks();
}

const kCreateEndpoint = "/test-api/book";
const kGetEndpoint = "/test-api/book";

class BookRemoteDataSourceImplimentation implements BookRemoteDataSource {
  BookRemoteDataSourceImplimentation(this._client);
  final http.Client _client;

  @override
  Future<void> createBook(
      {required String title,
      required String description,
      required String author}) async {
    final response = await _client.post(Uri.https(kBaseUrl, kCreateEndpoint),
        body: jsonEncode(
            {"title": title, "author": author, "description": description}));
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw APIException(
          statusCode: response.statusCode, message: response.body);
    }
  }

  @override
  Future<List<BookModel>> getBooks() async {
    try {
      final response = await _client.get(Uri.https(kBaseUrl, kGetEndpoint));

    if (response.statusCode != 200) {
      throw APIException(
          statusCode: response.statusCode, message: response.body);
    }

    return List<DataMap>.from(jsonDecode(response.body) as List)
        .map((userData) => BookModel.fromMap(userData))
        .toList();
    }
    on APIException{
      rethrow;
    }
     catch (e) {
      throw(APIException(statusCode: 505, message: e.toString()));
    }
    
  }
}
