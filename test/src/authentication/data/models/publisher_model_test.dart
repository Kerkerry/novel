import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/publisher.dart';
import 'package:novels/src/authentication/data/models/publisher_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = PublisherModel.empty();

  test("should be a subclass of [Publisher]", () {
    expect(tModel, isA<Publisher>());
  });

  final tJson = fixture("publisher.json");
  final tMap = jsonDecode(tJson) as DataMap;
  group("fromMap", () {
    test("should return [PublisherModel] with the right data", () {
      final result = PublisherModel.fromMap(tMap);
      expect(result, tModel);
    });
  });

  group("fromJson", () {
    test("should return [PublisherModel] with the right data", () {
      final result = PublisherModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group("toMap", () {
    test("should return a Map with the right data", () {
      final result = tModel.toMap();
      expect(result, equals(tMap));
    });
  });

  group("toJson", () {
    final tJson = jsonEncode({
      "id": "1",
      "name": "name",
      "email": "email",
      "city": "city",
      "country": "country"
    });
    test("should return Json with the right data", () {
      final result = tModel.toJson();
      expect(result, equals(tJson));
    });
  });

  group("copyWith", () { 
    test("should return a [PublisherModel] with modefied data", (){
      final modified=tModel.copyWith(name: "Jenifer Parker");
      expect(modified.name, equals("Jenifer Parker"));
      expect(modified.email, equals("email"));
    });
  });
}
