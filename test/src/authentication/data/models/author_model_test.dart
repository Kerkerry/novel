import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/author.dart';
import 'package:novels/src/authentication/data/models/author_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = AuthorModel.empty();

  test("should be a subclass of <Author>", () {
    expect(tModel, isA<Author>());
  });

  final tJson = fixture("author.json");
  final tMap = jsonDecode(tJson) as DataMap;

  group("fromMap", () {
    test("should return [AuthorModel] with the right data", () {
      final result = AuthorModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group("fromJson", () {
    
    test("should return [AuthorModel] with the right data", () {
      final result=AuthorModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group("toMap", () { 
    test("should return [Map] with the right data", () {
      final result=tModel.toMap();
      expect(result, equals(tMap));
    });
  });

  group("toJson", () { 
    final tJson = jsonEncode({
      "id": "1",
      "name": "name",
      "email": "email",
      "book": "book",
    });
    test("should return [Json] with the right data", (){
      final result=tModel.toJson();
      expect(result, equals(tJson));
    });
  });
}


// https://colab.research.google.com/drive/1HCAmQ89JTBPbpg0iX8juO0Dte2K5oB07?usp=sharing#scrollTo=TBakRp8MZfuY

// https://afterwork.ai/sign-in
// https://colab.research.google.com/drive/12Y7P39XAmqjAbERcbL54kp5d9E4_RUwf#scrollTo=lW_DJaEG_Bdx