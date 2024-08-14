import 'dart:convert';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/entities/book.dart';

class BookModel extends Book {
  const BookModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.author});

   BookModel.fromMap(DataMap map)
      : this(
            title: map['title'] as String,
            description: map['description'] as String,
            author: map['author'] as String,
            id: map['id'] as String);

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(jsonDecode(source) as DataMap);

  DataMap toMap() =>
      {'id': id, "title": title, "description": description, author: "author"};

  String toJson() => jsonEncode(toMap());

  BookModel copyWith(
      {String? id, String? title, String? description, String? author}) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      author: author ?? this.author,
    );
  }

  const BookModel.empty():this(id: "1",title: "title",description: "description",author: "author");
}
