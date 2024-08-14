import 'package:equatable/equatable.dart';
import 'package:novels/core/usecase/usecase.dart';
import 'package:novels/core/utils/type_def.dart';
import 'package:novels/src/authentication/domain/repository/book_repository.dart';

class CreateBook extends UseCaseWithParams<void,BookParams>{
    const CreateBook(this._repository);
  final BookRepository _repository;

  @override
  ResultFutureVoid call(BookParams params)async=>_repository.createBook(title: params.title, description: params.description, author: params.author);
}

class BookParams extends Equatable{
  final String title;
  final String description;
  final String author;
  const BookParams({required this.title,required this.description,required this.author});

  @override
  List<String> get props=>[title,description,author];

  const BookParams.empty():this(author: "author",description: "description",title: "title");
}