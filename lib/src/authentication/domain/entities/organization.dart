import 'package:equatable/equatable.dart';

class Organization extends Equatable {
  const Organization({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
    required this.specialization,
  });

  final String id;
  final String name;
  final String email;
  final String city;
  final String specialization;

  @override
  List<Object?> get props => [];

  const Organization.empty():this(id: "1",name: "name",email: "email",city: "city",specialization: "specialization");
}
