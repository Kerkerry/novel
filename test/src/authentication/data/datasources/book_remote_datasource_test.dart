import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/utils/constants.dart';
import 'package:novels/src/authentication/data/datasources/book_remote_datasource.dart';
import 'package:novels/src/authentication/data/models/book_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late BookRemoteDataSource dataSource;
  late http.Client client;

  setUp(() {
    client = MockClient();
    dataSource = BookRemoteDataSourceImplimentation(client);
    registerFallbackValue(Uri());
  });

  group("createBook", () {
    test("should complete successful when the status code is 200 or 201",
        () async {
      // Arrange
      when(() => client.post(any(), body: any(named: "body"))).thenAnswer(
          (_) async => http.Response("Book created successfully", 201));

      // Act
      final methodCall = dataSource.createBook;
      // Assert
      expect(
          methodCall(
              title: "title", author: "author", description: "description"),
          completes);
      verify(
        () => client.post(Uri.https(kBaseUrl, kCreateEndpoint),
            body: jsonEncode({
              "title": "title",
              "author": "author",
              "description": "description"
            })),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test("should throw [APIException] if the status code is not 200 or 201",
        () async {
      // Arrange
      when(
        () => client.post(any(), body: any(named: "body")),
      ).thenAnswer((_) async => http.Response("Invalid book title", 400));
      // Act
      final methodCall = dataSource.createBook;
      // Assert
      expect(
          ()async=>methodCall(
              title: "title", author: "author", description: "description"),
          throwsA(const APIException(
              statusCode: 400, message: "Invalid book title")));
      verify(
        () => client.post(Uri.https(kBaseUrl, kCreateEndpoint),
            body: jsonEncode({
              "title": "title",
              "author": "author",
              "description": "description"
            })),
      ).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group("getUsers", () {
    const tResponse = [BookModel.empty()];
    test(
        "should return List<UserModel> when it is successful and the status code is 200",
        () async {
      // Arrange
      when(
        () => client.get(any()),
      ).thenAnswer((_) async =>
          http.Response(jsonEncode([tResponse.first.toMap()]), 200));
      // Act
      final response = await dataSource.getBooks();

      // expect
      expect(response, equals(tResponse));
      verify(
        () => client.get(Uri.https(kBaseUrl, kGetEndpoint)),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test("should throw [APIException] when the status code is not 200",
        () async {
      // Arrange
      when(
        () => client.get(any()),
      ).thenAnswer((_) async => http.Response(
          "Server is down at the moment, please come back later", 500));

      // Act
      final methodCall= dataSource.getBooks;

      // Assert
      expect(()async=>methodCall(), throwsA(const APIException(statusCode: 500, message: "Server is down at the moment, please come back later")));
      verify(() => client.get(Uri.https(kBaseUrl, kGetEndpoint)),).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
