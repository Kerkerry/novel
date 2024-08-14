import 'package:equatable/equatable.dart';

class Author extends Equatable{
  final String id;
  final String name;
  final String email;
  final String book;

 const Author({required this.id, required this.name, required this.email, required this.book});
  @override
  List<Object?> get props=>[id,name,email,book];

  Author.empty():this(id: "1", name: "name",email: "email",book: "book");
}