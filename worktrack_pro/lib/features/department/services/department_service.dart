import '../models/department_model.dart';
import '../repositories/department_repository.dart';

class DepartmentService {
  DepartmentService({
    DepartmentRepository? repository,
  }) : _repository = repository ?? DepartmentRepository();

  final DepartmentRepository _repository;

  Future<List<DepartmentModel>> getDepartments({
    required String companyId,
  }) async {
    return await _repository.getDepartments(
      companyId: companyId,
    );
  }

  Future<DepartmentModel> createDepartment({
    required DepartmentModel department,
  }) async {
    final exists =
    await _repository.departmentNameExists(
      companyId: department.companyId,
      departmentName: department.departmentName,
    );

    if (exists) {
      throw Exception(
        'Department already exists.',
      );
    }

    return await _repository.createDepartment(
      department: department,
    );
  }

  Future<DepartmentModel> updateDepartment({
    required DepartmentModel department,
  }) async {
    final exists =
    await _repository.departmentNameExists(
      companyId: department.companyId,
      departmentName: department.departmentName,
      excludeId: department.id,
    );

    if (exists) {
      throw Exception(
        'Department already exists.',
      );
    }

    return await _repository.updateDepartment(
      department: department,
    );
  }

  Future<void> deleteDepartment(
      String id,
      ) async {
    await _repository.deleteDepartment(id);
  }

  Future<DepartmentModel?> getDepartmentById(
      String id,
      ) async {
    return await _repository.getDepartmentById(
      id,
    );
  }
}