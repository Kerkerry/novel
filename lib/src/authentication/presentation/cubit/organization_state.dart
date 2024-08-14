part of 'organization_cubit.dart';

sealed class OrganizationState extends Equatable {
  const OrganizationState();

  @override
  List<Object> get props => [];
}

final class OrganizationInitial extends OrganizationState {}

class CreatingOrganizationState extends OrganizationState{
  const CreatingOrganizationState();
}

class OrganizationCreatedState extends OrganizationState{

  const OrganizationCreatedState();

}

class GetOrganizationState extends OrganizationState{
  const GetOrganizationState();
}

class OrganizationsLoadedState extends OrganizationState{
  final List<Organization> organizations;
  const OrganizationsLoadedState(this.organizations);

  @override
  List<String> get props=>organizations.map((org) => org.id).toList();
}


class OrganizationErrorState extends OrganizationState{
final String message;
const OrganizationErrorState(this.message);

@override
List<String> get props=>[message];
}


