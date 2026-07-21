import '../models/designation_model.dart';
import '../repositories/designation_repository.dart';

class DesignationService {
  DesignationService({
    DesignationRepository? repository,
  }) : _repository =
      repository ?? DesignationRepository();

  final DesignationRepository _repository;

  Future<List<DesignationModel>> getDesignations({
    required String companyId,
  }) async {
    return await _repository.getDesignations(
      companyId: companyId,
    );
  }

  Future<List<DesignationModel>>
  getByDepartment({
    required String departmentId,
  }) async {
    return await _repository.getByDepartment(
      departmentId: departmentId,
    );
  }

  Future<DesignationModel?> getDesignationById(
      String id,
      ) async {
    return await _repository.getDesignationById(
      id,
    );
  }

  Future<DesignationModel> createDesignation({
    required DesignationModel designation,
  }) async {
    final exists =
    await _repository.designationNameExists(
      companyId: designation.companyId,
      designationName:
      designation.designationName,
    );

    if (exists) {
      throw Exception(
        'Designation already exists.',
      );
    }

    return await _repository.createDesignation(
      designation: designation,
    );
  }

  Future<DesignationModel> updateDesignation({
    required DesignationModel designation,
  }) async {
    final exists =
    await _repository.designationNameExists(
      companyId: designation.companyId,
      designationName:
      designation.designationName,
      excludeId: designation.id,
    );

    if (exists) {
      throw Exception(
        'Designation already exists.',
      );
    }

    return await _repository.updateDesignation(
      designation: designation,
    );
  }

  Future<void> deleteDesignation(
      String id,
      ) async {
    await _repository.deleteDesignation(
      id,
    );
  }
}