import 'package:equatable/equatable.dart';

class Book extends Equatable{
  final String id;
  final String title;
  final String description;
  final String author;

  const Book({required this.id, required this.title, required this.description, required this.author});
  
  @override
  List<Object?> get props =>[id,title,description,author];

  const Book.empty():this(id:"1",title:"title",description:"description",author:"author");
}