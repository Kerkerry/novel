import 'dart:convert';

import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/utils/constants.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/data/models/publisher_model.dart';
import 'package:http/http.dart' as http;

abstract class PublisherRemoteDatasource {
  const PublisherRemoteDatasource();

  Future<void> createPublisher(
      {required String name,
      required String email,
      required String city,
      required String country});

  Future<List<PublisherModel>> getPublishers();
}

const kCreatePublisherEndpoint = "/test_api/publishers";
const kGetPublishersEndpoint = "/test_api/publishers";

class PublisherRemoteDatasourceImplementation
    implements PublisherRemoteDatasource {
  const PublisherRemoteDatasourceImplementation(this._client);
  final http.Client _client;

  @override
  Future<void> createPublisher(
      {required String name,
      required String email,
      required String city,
      required String country}) async {
    final response = await _client.post(
        Uri.https(kBaseUrl, kCreatePublisherEndpoint),
        body: jsonEncode(
            {"name": name, "email": email, "city": city, "country": country}));

    if (response.statusCode != 200) {
      throw APIException(
          statusCode: response.statusCode, message: response.body);
    }
  }

  @override
  Future<List<PublisherModel>> getPublishers() async{
   try {
      final response=await _client.get(Uri.https(kBaseUrl,kGetPublishersEndpoint));

    if(response.statusCode!=200){
      throw(APIException(statusCode: response.statusCode, message: response.body));
    }
    return List<DataMap>.from(jsonDecode(response.body) as List).map((publisher) => PublisherModel.fromMap(publisher)).toList();
   } 
   on APIException {
    rethrow;
   }
   catch (e) {
     throw(APIException(statusCode: 500, message: e.toString()));
   }
  }
}
