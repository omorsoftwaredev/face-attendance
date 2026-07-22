import '../models/department_model.dart';
import '../repositories/department_repository.dart';

class DepartmentService {
  DepartmentService({
    DepartmentRepository? repository,
  }) : _repository = repository ?? DepartmentRepository();

  final DepartmentRepository _repository;

  /// Get All Departments
  Future<List<DepartmentModel>> getDepartments({
    required String companyId,
  }) async {
    try {
      return await _repository.getDepartments(
        companyId: companyId,
      );
    } catch (e) {
      throw Exception(
        'Failed to load departments.\n$e',
      );
    }
  }

  /// Get Department By ID
  Future<DepartmentModel?> getDepartmentById(
      String id,
      ) async {
    try {
      return await _repository.getDepartmentById(id);
    } catch (e) {
      throw Exception(
        'Failed to load department.\n$e',
      );
    }
  }

  /// Create Department
  Future<DepartmentModel> createDepartment({
    required DepartmentModel department,
  }) async {
    try {
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
    } catch (e) {
      throw Exception(
        'Failed to create department.\n$e',
      );
    }
  }

  /// Update Department
  Future<DepartmentModel> updateDepartment({
    required DepartmentModel department,
  }) async {
    try {
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
    } catch (e) {
      throw Exception(
        'Failed to update department.\n$e',
      );
    }
  }

  /// Delete Department
  Future<void> deleteDepartment(
      String id,
      ) async {
    try {
      await _repository.deleteDepartment(id);
    } catch (e) {
      throw Exception(
        'Failed to delete department.\n$e',
      );
    }
  }
}