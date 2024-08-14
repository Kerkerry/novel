import 'dart:convert';

import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/author.dart';

class AuthorModel extends Author {
  const AuthorModel({
    required super.id,
    required super.name,
    required super.email,
    required super.book,
  });

  AuthorModel.fromMap(DataMap map)
      : this(
            id: map['id'] as String,
            name: map['name'] as String,
            email: map['email'] as String,
            book: map['book'] as String);

  factory AuthorModel.fromJson(String source) =>
      AuthorModel.fromMap(jsonDecode(source) as DataMap);

  DataMap toMap() => {'id': id, 'name': name, 'email': email, 'book': book};

  String toJson() => jsonEncode(toMap());

  AuthorModel copyWith({
    String? id,
    String? name,
    String? email,
    String? book,
  }) {
    return AuthorModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        book: book ?? this.book);
  }

  const AuthorModel.empty():this(id: "1",name: "name",email: "email",book: "book");
}


