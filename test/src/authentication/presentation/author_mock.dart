import 'package:mocktail/mocktail.dart';
import 'package:novels/core/errors/failure.dart';
import 'package:novels/src/authentication/domain/usecases/author/create_author.dart';
import 'package:novels/src/authentication/domain/usecases/author/get_authors.dart';

class MockCreateAuthor extends Mock implements CreateAuthor {}

class MockGetAuthors extends Mock implements GetAuthors {}

const tParams = AuthorParams.empty();
const tFailure = Failure(message: "Server failure", statusCode: 500);
