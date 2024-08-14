import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novels/src/authentication/domain/entities/organization.dart';
import 'package:novels/src/authentication/domain/usecases/organization/create_organization.dart';
import 'package:novels/src/authentication/domain/usecases/organization/get_organizations.dart';

part 'organization_state.dart';

class OrganizationCubit extends Cubit<OrganizationState> {
  final CreateOrganization _createOrganization;
  final GetOrganizations _getOrganizations;
  OrganizationCubit({required CreateOrganization createOrganization,required GetOrganizations getOrganizations}) : 
  _createOrganization=createOrganization,
  _getOrganizations=getOrganizations,
  super(OrganizationInitial());

  Future<void> createOrganization({required String name,required String email,required String city, required String specialization})async{
    emit(const CreatingOrganizationState());
    final result=await _createOrganization(OrganizationParams(name: name, email: email, city: city, specialization: specialization));

    result.fold((failure) => emit(OrganizationErrorState(failure.message)), (_) => emit(const OrganizationCreatedState()));
  }

  Future<void> getOrganizations()async{
    emit(const GetOrganizationState());
    final result=await _getOrganizations();

    result.fold((failure) => emit(OrganizationErrorState(failure.message)), (organizations) => emit(OrganizationsLoadedState(organizations)));
  }
}
