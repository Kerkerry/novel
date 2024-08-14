import 'dart:convert';

import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/publisher.dart';

class PublisherModel extends Publisher {
  const PublisherModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.city,
      required super.country});

  PublisherModel.fromMap(DataMap map)
      : this(
          id: map['id'],
          name: map['name'],
          email: map['email'],
          city: map['city'],
          country: map['country'],
        );
  factory PublisherModel.fromJson(String source) =>
      PublisherModel.fromMap(jsonDecode(source) as DataMap);

  DataMap toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "city": city,
        "country": country
      };

  String toJson() => jsonEncode(toMap());

  PublisherModel copyWith(
      {String? id,
      String? name,
      String? email,
      String? city,
      String? country}) {
    return PublisherModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        city: city ?? this.city,
        country: country ?? this.country);
  }

 const PublisherModel.empty()
      : this(
            id: "1",
            name: "name",
            email: "email",
            city: "city",
            country: "country");
}
