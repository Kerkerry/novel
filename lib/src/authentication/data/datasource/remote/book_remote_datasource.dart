import 'dart:convert';

import 'package:novel/core/constants/constants.dart';
import 'package:novel/core/errors/failure.dart';

import 'package:http/http.dart' as http;
import 'package:novel/core/utils/custom_methods.dart';
import 'package:novel/core/utils/typedef.dart';
import 'package:novel/src/authentication/data/model/book_model.dart';

abstract class BookRemoteDatasource {
  const BookRemoteDatasource();

  Future<void> createBook(
      {required String title,
      required String description,
      required String author,
      required String createdAt});
  
  Future<void> updateBook(String id, BookModel book);

  Future<void> deleteBook(String id);

  Future<List<BookModel>> getBooks();
}

const kBookEndpoint = "test-api/book";


class BookRemoteDatasourceImplementation extends BookRemoteDatasource {
  final http.Client _client;
  const BookRemoteDatasourceImplementation(this._client);
  @override
  Future<void> createBook(
      {required String title,
      required String description,
      required String author,
      required String createdAt}) async {
    try {
      final response = await _client.post(Uri.https(kBaseUrl, kBookEndpoint),
          body: jsonEncode({
            "title": title,
            "description": description,
            "author": author,
            "createdAt": createdAt
          }),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw (APIException(
            statusCode: response.statusCode, message: response.body));
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw (APIException(statusCode: 505, message: e.toString()));
    }
  }

  @override
  Future<List<BookModel>> getBooks() async {
    try {
      final response = await _client.get(Uri.https(kBaseUrl, kBookEndpoint));
      if (response.statusCode != 200) {
        throw (APIException(
            statusCode: response.statusCode, message: response.body));
      }

      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((book) => BookModel.fromMap(book))
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw (APIException(statusCode: 505, message: e.toString()));
    }
  }
  
  @override
  Future<void> deleteBook(String id)async {
    try {
      final repsonse=await _client.delete(Uri.https(kBaseUrl,kIdEndPoint(id)));

      if(repsonse.statusCode!=200){
        throw(APIException(message: repsonse.body,statusCode: repsonse.statusCode));
      }
    }on APIException{
      rethrow;
    } catch (e) {
      throw(APIException(message: e.toString(),statusCode: 505));
    }
  }
  
  @override
  Future<void> updateBook(String id, BookModel book) async{
    try {
      final response=await _client.put(Uri.https(kBaseUrl,kIdEndPoint(id)),body: book.toJson(), headers: {"Content-Type":"application/json"});
      if(response.statusCode!=200){
        throw(APIException(message: response.body, statusCode: response.statusCode));
      }
    }on APIException{
      rethrow;
    } catch (e) {
      throw(APIException(statusCode: 505, message: e.toString()));
    }
  }
}
