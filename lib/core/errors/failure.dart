import 'package:equatable/equatable.dart';
import 'package:novels/core/errors/exceptions.dart';

class Failure extends Equatable{
  final int statusCode;
  final String message;
  const Failure({required this.statusCode,required this.message});

  @override
  List<Object> get props=>[statusCode,message];
}


class APIFailure extends Failure{
  const APIFailure({required super.statusCode, required super.message});

  APIFailure.fromException(APIException exception):this(message: exception.message,statusCode: exception.statusCode);
  
}