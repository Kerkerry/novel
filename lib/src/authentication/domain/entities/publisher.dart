import 'package:equatable/equatable.dart';

class Publisher extends Equatable{
  const Publisher({required this.id,required this.name,required this.email,required this.city,required this.country});

  final String id;
  final String name;
  final String email;
  final String city;
  final String country;

  @override
  List<String> get props=>[id,name,email,city,country];

  const Publisher.empty():this(id: "1",name: "name",email: "email",city: "city",country: "country");
}