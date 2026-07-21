import '../models/employee_model.dart';
import '../repositories/employee_repository.dart';

class EmployeeService {
  EmployeeService({
    EmployeeRepository? repository,
  }) : _repository = repository ?? EmployeeRepository();

  final EmployeeRepository _repository;

  /// Get All Employees
  Future<List<EmployeeModel>> getEmployees() async {
    try {
      return await _repository.getEmployees();
    } catch (e) {
      throw Exception(
        'Failed to load employees.\n$e',
      );
    }
  }

  /// Get Employee By ID
  Future<EmployeeModel?> getEmployeeById(
      String id,
      ) async {
    try {
      return await _repository.getEmployeeById(id);
    } catch (e) {
      throw Exception(
        'Failed to load employee.\n$e',
      );
    }
  }

  /// Create Employee
  Future<void> createEmployee({
    required String companyId,
    String? departmentId,
    required String employeeCode,
    required String fullName,
    String? email,
    String? phone,
    String? designationName,
    String? profilePhoto,
  }) async {
    try {
      await _repository.createEmployee(
        companyId: companyId,
        departmentId: departmentId,
        employeeCode: employeeCode,
        fullName: fullName,
        email: email,
        phone: phone,
        designationName: designationName,
        profilePhoto: profilePhoto,
      );
    } catch (e) {
      throw Exception(
        'Failed to create employee.\n$e',
      );
    }
  }

  /// Update Employee
  Future<void> updateEmployee({
    required String id,
    required String companyId,
    String? departmentId,
    required String employeeCode,
    required String fullName,
    String? email,
    String? phone,
    String? designationName,
    String? profilePhoto,
    required bool isActive,
  }) async {
    try {
      await _repository.updateEmployee(
        id: id,
        companyId: companyId,
        departmentId: departmentId,
        employeeCode: employeeCode,
        fullName: fullName,
        email: email,
        phone: phone,
        designationName: designationName,
        profilePhoto: profilePhoto,
        isActive: isActive,
      );
    } catch (e) {
      throw Exception(
        'Failed to update employee.\n$e',
      );
    }
  }

  /// Delete Employee
  Future<void> deleteEmployee(
      String id,
      ) async {
    try {
      await _repository.deleteEmployee(id);
    } catch (e) {
      throw Exception(
        'Failed to delete employee.\n$e',
      );
    }
  }
}