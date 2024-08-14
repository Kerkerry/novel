import 'package:mocktail/mocktail.dart';
import 'package:novels/core/errors/failure.dart';
import 'package:novels/src/authentication/domain/usecases/book/create_book.dart';
import 'package:novels/src/authentication/domain/usecases/book/get_books.dart';

class MockCreateBook extends Mock implements CreateBook {}

class MockGetBooks extends Mock implements GetBooks {}
 const tParams = BookParams.empty();
  const tFailure = Failure(message: "Server failure", statusCode: 400);