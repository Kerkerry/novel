import 'dart:convert';

import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/utils/constants.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/data/models/organization_model.dart';
import 'package:http/http.dart' as http;
abstract class OrganizationRemoteDataSource {
  Future<void> createOrganization({
    required String name,
    required String email,
    required String city,
    required String specialization,
  });
  Future<List<OrganizationModel>> getOrganizations();
}

const kCreateOrganizationEndpoint="/test_api/organization";
const kGetOrganizationEndpoint="/test_api/organization";
class OrganizationRemoteDataSourceImplimentation implements OrganizationRemoteDataSource{
  const OrganizationRemoteDataSourceImplimentation(this._client);
  final http.Client _client;
  
  @override
  Future<void> createOrganization({required String name, required String email, required String city, required String specialization})async {
    final response=await _client.post(Uri.https(kBaseUrl,kCreateOrganizationEndpoint),body: jsonEncode({"name":name,"email":email,"city":city,"specialization":specialization}));
    if(response.statusCode!=200 && response.statusCode!=201){
      throw(APIException(statusCode: response.statusCode, message: response.body));
    }
  }
  
  @override
  Future<List<OrganizationModel>> getOrganizations() async{
   try {
      final response=await _client.get(Uri.https(kBaseUrl,kCreateOrganizationEndpoint));
    if(response.statusCode!=200){
      throw(APIException(statusCode: response.statusCode, message: response.body));
    }
    return List<DataMap>.from(jsonDecode(response.body) as List).map((org) => OrganizationModel.fromMap(org)).toList();
   } 
   on APIException{
    rethrow;
   }
   catch (e) {
     throw(APIException(statusCode: 505, message: e.toString()));
   }

  }
}