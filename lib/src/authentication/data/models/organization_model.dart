import 'dart:convert';

import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/organization.dart';

class OrganizationModel extends Organization {
  const OrganizationModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.city,
      required super.specialization});

  OrganizationModel.fromMap(DataMap map)
      : this(
          id: map['id'],
          name: map['name'],
          email: map['email'],
          city: map['city'],
          specialization: map['specialization'],
        );
  factory OrganizationModel.fromJson(String source) =>
      OrganizationModel.fromMap(jsonDecode(source));

  DataMap toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "city": city,
        "specialization": specialization
      };

  String toJson() => jsonEncode(toMap());

  OrganizationModel copyWith(
      { String? id,
       String? name,
       String? email,
       String? city,
       String? specialization}) {
    return OrganizationModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        city: city ?? this.city,
        specialization: specialization ?? this.specialization);
  }

  const OrganizationModel.empty()
      : this(
          id: "1",
          name: "name",
          email: "email",
          city: "city",
          specialization: "specialization",
        );
}
