import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novels/src/authentication/domain/entities/organization.dart';
import 'package:novels/src/authentication/domain/usecases/organization/create_organization.dart';
import 'package:novels/src/authentication/domain/usecases/organization/get_organizations.dart';

part 'organization_event.dart';
part 'organization_state.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  final CreateOrganization _createOrganization;
  final GetOrganizations _getOrganizations;
  OrganizationBloc(
      {required CreateOrganization createOrganization,
      required GetOrganizations getOrganizations})
      : _createOrganization = createOrganization,
        _getOrganizations = getOrganizations,
        super(OrganizationInitial()) {
    on<CreateOrganizationEvent>(_createOrganizationHandler);
    on<GetOrganizationEvent>(_getOrganizationsHandler);
  }

  Future<void> _createOrganizationHandler(
      CreateOrganizationEvent event, Emitter<OrganizationState> emit) async {
    emit(const CreatingOrganizationState());
    final result = await _createOrganization(OrganizationParams(
        name: event.name,
        email: event.email,
        city: event.city,
        specialization: event.specialization));

    result.fold((failure) => emit(OrganizationErrorState(failure.message)),
        (_) => emit(const OrganizationCreatedState()));
  }

  Future<void> _getOrganizationsHandler(
      GetOrganizationEvent event, Emitter<OrganizationState> emit) async {
    emit(const GetOrganizationState());
    final result = await _getOrganizations();

    result.fold((failure) => emit(OrganizationErrorState(failure.message)),
        (organizations) => emit(OrganizationsLoadedState(organizations)));
  }
}
