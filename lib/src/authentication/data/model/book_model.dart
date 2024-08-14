import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:novel/core/utils/typedef.dart';
import 'package:novel/src/authentication/domain/entities/book.dart';

part 'book_model.g.dart';
@HiveType(typeId:0)
class BookModel extends Book {
  const BookModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.author,
      required super.createdAt});
  

  BookModel.fromMap(DataMap map)
      : this(
            id: map['id'] as String,
            title: map['title'] as String,
            description: map['description'] as String,
            author: map['author'] as String,
            createdAt: map['createdAt'] as String);

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(jsonDecode(source) as DataMap);

  BookModel copyWith(
      {String? id,
      String? title,
      String? description,
      String? author,
      String? createdAt}) {
    return BookModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        author: author ?? this.author,
        createdAt: createdAt ?? this.createdAt);
  }

  DataMap toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "author": author,
        "createdAt": createdAt
      };

  String toJson() => jsonEncode(toMap());

  const BookModel.empty()
      : this(
            id: "1",
            title: "title",
            description: "description",
            author: "author",
            createdAt: "createdAt");
}
