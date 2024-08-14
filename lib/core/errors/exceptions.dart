import 'package:equatable/equatable.dart';

class APIException extends Equatable implements Exception{
  final String message;
  final int statusCode;
  const APIException({required this.statusCode,required this.message});
  @override
  List<Object> get props=>[statusCode,message];

  
}