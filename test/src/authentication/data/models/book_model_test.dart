import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/book.dart';
import 'package:novels/src/authentication/data/models/book_model.dart';

import '../../../../fixtures/fixture_reader.dart';


void main() {
  const tModel=BookModel.empty();

  test("should be a subclass of <Book> entity", (){
    expect(tModel, isA<Book>());
  });

  final tJson=fixture("book.json");
  final tMap=jsonDecode(tJson) as DataMap;

  group("fromMap", () { 
    test("should return a [BookModel] with the right data", (){
      final result=BookModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group("fromJson", () { 
    test("should return [BookModel] with the right data", (){
      final result=BookModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group("toMap", () { 
    test("should return [Map] with the right data", (){
      final result=tModel.toMap();
      expect(result, equals(tMap));
    });
  });

  group("toJson", () {
    final tJson=jsonEncode({'id':"1",'title':'title','description':'description','author':'author'});
    test("should return [Json] with the right data", () {
      final result=tModel.toJson();
      expect(result, equals(tJson));
    });
   });
}