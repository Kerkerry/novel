import 'package:mocktail/mocktail.dart';
import 'package:novels/core/errors/failure.dart';
import 'package:novels/src/authentication/domain/usecases/organization/create_organization.dart';
import 'package:novels/src/authentication/domain/usecases/organization/get_organizations.dart';

class MockCreateOrganization extends Mock implements CreateOrganization {}

class MockGetOrganizations extends Mock implements GetOrganizations {}
  const tParams = OrganizationParams.empty();
  const tFailure = Failure(statusCode: 400, message: "Oops! server failure");