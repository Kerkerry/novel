import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/organization.dart';
import 'package:novels/src/authentication/data/models/organization_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel=OrganizationModel.empty();

  test("should be subclass of [Organization]", (){
    expect(tModel, isA<Organization>());
  });

  final tJson=fixture("organization.json");
  final tMap=jsonDecode(tJson) as DataMap;
  group("fromMap", () { 
    test("should return [OrganizationModel] with the right data", (){
      final result=OrganizationModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group("fromJson", () { 
    test("should return [OrganizationModel] with the right data", () {
      final result=OrganizationModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group("toMap", () {
      test("should return a Map with the right data", (){
        final result=tModel.toMap();
        expect(result, equals(tMap));

      });
   });

   group("toJson", () { 
    final tJson=jsonEncode({
      "id":"1",
      "name":"name",
      "email":"email",
      "city":"city",
      "specialization":"specialization"
    });
    test("should return Json with the right data", (){
      final result =tModel.toJson();
      expect(result, equals(tJson));
    });
   });


   group("copyWith", () { 
    test("should return [OrganizationModel] with different data which is modefied", () {
      const orgData0=OrganizationModel(id: "2", name: "Podii", email: "poddi@hg.co.ke", city: "Nairobi", specialization: "software Engineering");
      final orgData1=orgData0.copyWith(name: "Andela Software Company");
      expect(orgData1.name, equals("Andela Software Company"));
      expect(orgData1.city, equals("Nairobi"));
    });
   });
}