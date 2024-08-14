part of 'organization_bloc.dart';

sealed class OrganizationEvent extends Equatable {
  const OrganizationEvent();

  @override
  List<Object> get props => [];
}

class CreateOrganizationEvent extends OrganizationEvent{
  final String name;
  final String email;
  final String city;
  final String specialization;

  const CreateOrganizationEvent({required this.name, required this.email, required this.city, required this.specialization});
}

class GetOrganizationEvent extends OrganizationEvent{
  const GetOrganizationEvent();
}
