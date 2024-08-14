import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/utils/constants.dart';
import 'package:novels/src/authentication/data/datasources/publisher_remote_datasource.dart';
import 'package:novels/src/authentication/data/models/publisher_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late PublisherRemoteDatasource datasource;
  setUp(() {
    client = MockClient();
    datasource = PublisherRemoteDatasourceImplementation(client);
    registerFallbackValue(Uri());
  });

  group("createPublisher", () {
    test("should complete successful when the status code is 200 or 201",
        () async {
      // Arrange
      when(
        () => client.post(any(), body: any(named: "body")),
      ).thenAnswer(
          (_) async => http.Response("Publisher created successful", 201));
      // Act
      final methodCall = datasource.createPublisher;

      // Assert
      expect(
          methodCall(
              name: "name", email: "email", city: "city", country: "country"),
          completes);
      verify(
        () => client.post(Uri.https(kBaseUrl, kCreatePublisherEndpoint),
            body: jsonEncode({
              "name": "name",
              "email": "email",
              "city": "city",
              "country": "country"
            })),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test(
        "should throw an [APIException] when the status code is not 201 or 200",
        () async {
      // Arrange
      when(
        () => client.post(any(), body: any(named: "body")),
      ).thenAnswer((_) async => http.Response("Invalid email address", 400));

      // Act
      final methodCall = datasource.createPublisher;

      // Assert
      expect(
          () => methodCall(
              name: "name", email: "email", city: "city", country: "country"),
          throwsA(const APIException(
              statusCode: 400, message: "Invalid email address")));
    });
  });

  group("getUsers", () { 
    const tPublishers=[PublisherModel.empty()];
    test("should return a [List<PublisherModel>] when it successful and the status code is 200", ()async {
      // Arrange
      when(() => client.get(any()),).thenAnswer((_) async=> http.Response(jsonEncode([tPublishers.first.toMap()]),200));
      // Act
      final result=await datasource.getPublishers();
      // Assert
      expect(result, equals(tPublishers));
      verify(() => client.get(Uri.https(kBaseUrl,kGetPublishersEndpoint)),).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  test("should throw [APIException] if the status code is not 200", ()async{
    // Arrange
    when(() => client.get(any()),).thenAnswer((_) async=>http.Response("Server is down, come back later",400) );

    // Act
    final methodCall=datasource.getPublishers;

    // Assert
    expect(()=>methodCall(), throwsA(const APIException(statusCode: 400, message: "Server is down, come back later")));
    verify(() => client.get(Uri.https(kBaseUrl,kGetPublishersEndpoint)),).called(1);
    verifyNoMoreInteractions(client);
  });
}
