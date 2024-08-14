import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/utils/constants.dart';
import 'package:novels/src/authentication/data/datasources/organization_remote_datasource.dart';
import 'package:novels/src/authentication/data/models/organization_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late  OrganizationRemoteDataSource datasource;
  setUp((){
    client=MockClient();
    datasource=OrganizationRemoteDataSourceImplimentation(client);
    registerFallbackValue(Uri());
  });

  
  group("createOrganization", () { 
    String tJson=jsonEncode({
        "name": "name","email":"email","city":"city","specialization":"specialization"
      });
    test("should complete successful when the status code is 200 or 201", ()async{
      // Arrange
      when(() => client.post(any(),body: any(named: "body")),).thenAnswer((_)async=>http.Response("Organization created successful",201));
      // Act
      final methodCall=datasource.createOrganization;
      // assert
      expect(methodCall(name: "name",email:"email",city:"city",specialization:"specialization"), completes);
      verify(() => client.post(Uri.https(kBaseUrl,kCreateOrganizationEndpoint),body: tJson),).called(1);
      verifyNoMoreInteractions(client);
    });
    test("should throw an [APIException] if the status code is not 200 or 201", (){
      // Arrange
      when(() => client.post(any(),body: any(named: "body")),).thenAnswer((_)async=>http.Response("Invalid email",400));
      // Act
      final methodCall=datasource.createOrganization;
      // Assert
      expect(()=>methodCall(name: "name",email:"email",city:"city",specialization:"specialization"), throwsA(const APIException(statusCode: 400, message: "Invalid email")));
      verify(() => client.post(Uri.https(kBaseUrl,kCreateOrganizationEndpoint),body: tJson),).called(1);
    });
  });

  group("getOrganization", () { 
    const tOrganization=[OrganizationModel.empty()];
    test("should return [List<OrganizationMdel>] when the status code is 200", ()async {
      //arrange
      when(() => client.get(any()),).thenAnswer((_)async=>http.Response(jsonEncode([tOrganization.first.toMap()]),200));
      // Act
      final result=await datasource.getOrganizations();
      // assert
      expect(result, equals(tOrganization));
      verify(() => client.get(Uri.https(kBaseUrl,kGetOrganizationEndpoint)),).called(1);
      verifyNoMoreInteractions(client);
    });

    test("should throw an [APIException] when the status code is not 200", ()async{
      when(() => client.get(any()),).thenAnswer((_)async=>http.Response("Server under maintenance, come back after an hour",400));

      final methodCall=datasource.getOrganizations;

      expect(()=>methodCall(), throwsA(const APIException(statusCode: 400, message: "Server under maintenance, come back after an hour")));
      verify(() => client.get(Uri.https(kBaseUrl,kGetOrganizationEndpoint)),).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
