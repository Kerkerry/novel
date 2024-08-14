
import 'package:dartz/dartz.dart';
import 'package:novels/core/errors/failure.dart';

typedef ResultFuture<T>=Future<Either<Failure,T>>;

typedef ResultFutureVoid=ResultFuture<void>;

typedef DataMap=Map<String,dynamic>;