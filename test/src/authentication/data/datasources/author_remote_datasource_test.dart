import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:novels/core/errors/exceptions.dart';
import 'package:novels/core/utils/constants.dart';
import 'package:novels/src/authentication/data/datasources/author_remote_datasource.dart';
import 'package:novels/src/authentication/data/models/author_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthorRemoteDataSource dataSource;
  setUp(() {
    client = MockClient();
    dataSource = AuthorRemoteDataSourceImplementation(client);
    registerFallbackValue(Uri());
  });

  group("createAuthor", () {
    test("should complete successful when the status code is 200 or 201",
        () async {
      // Arrange
      when(
        () => client.post(any(), body: any(named: "body")),
      ).thenAnswer(
          (_) async => http.Response("Author created successful", 200));

      // Act
      final methodCall = dataSource.createAuthor;

      // Assert
      expect(methodCall(name: "name", email: "email", book: "book"), completes);
      verify(
        () => client.post(Uri.https(kBaseUrl, kCreateAuthorEndpoint),
            body:
                jsonEncode({"name": "name", "email": "email", "book": "book"})),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test("should throw an [APIException] when the status code is not 200 or 201", ()async{
      // Arrange
      when(() => client.post(any(),body: any(named: "body")),).thenAnswer((_) async=>http.Response("Invalid email",400));

      // Act
      final methodCall=dataSource.createAuthor;

      // Assert
      expect(()async=>methodCall(name: "name",email:"email",book:"book"), throwsA(const APIException(statusCode: 400, message: "Invalid email")));
      verify(() => client.post(Uri.https(kBaseUrl,kCreateAuthorEndpoint),body: jsonEncode({"name":"name","email":"email","book":"book"})),).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group("getAuthors", () { 
   const tAuthors=[AuthorModel.empty()];
    test("should return [List<AuthorMdel>] when status code is 200", ()async{
      // Arrange
      when(() => client.get(any()),).thenAnswer((_) async=>http.Response(jsonEncode([tAuthors.first.toMap()]),200) );

      // Act
      final response=await dataSource.getAuthors();

      // Assert
      expect(response, equals(tAuthors));
      verify(() => client.get(Uri.https(kBaseUrl,kGetAuthorsEndpoint)),).called(1);
      verifyNoMoreInteractions(client);
    });

    test("should throw [APIException] when then status code is not 200", ()async{
      // Arrange
      when(() => client.get(any()),).thenAnswer((_) async=> http.Response("Server is down, come back later",400));
      // Act
      final methodCall=dataSource.getAuthors;

      // Assert
      expect(()=>methodCall(), throwsA(const APIException(statusCode: 400, message: "Server is down, come back later")));
      verify(() => client.get(Uri.https(kBaseUrl,kGetAuthorsEndpoint)),).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
