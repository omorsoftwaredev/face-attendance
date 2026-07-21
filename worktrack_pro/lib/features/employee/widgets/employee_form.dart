import 'package:flutter/material.dart';

import 'employee_actions.dart';
import 'employee_basic_info.dart';
import 'employee_contact.dart';
import 'employee_department.dart';

class EmployeeForm extends StatefulWidget {
  const EmployeeForm({
    super.key,
    this.employeeId,
  });

  final String? employeeId;

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final GlobalKey<FormState> _formKey =
  GlobalKey<FormState>();

  final TextEditingController _employeeCodeController =
  TextEditingController();

  final TextEditingController _fullNameController =
  TextEditingController();

  final TextEditingController _designationController =
  TextEditingController();

  final TextEditingController _emailController =
  TextEditingController();

  final TextEditingController _phoneController =
  TextEditingController();

  String? _departmentId;

  bool _isActive = true;

  bool get _isEdit => widget.employeeId != null;

  @override
  void dispose() {
    _employeeCodeController.dispose();
    _fullNameController.dispose();
    _designationController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveEmployee() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    /// Provider Integration
    /// Sprint-08 (Provider)
    ///
    /// Create:
    /// context.read<EmployeeProvider>().createEmployee(...)
    ///
    /// Update:
    /// context.read<EmployeeProvider>().updateEmployee(...)
    ///
    /// এটি employee_actions.dart থেকে trigger হবে।
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          EmployeeBasicInfo(
            employeeCodeController:
            _employeeCodeController,
            fullNameController:
            _fullNameController,
            designationController:
            _designationController,
          ),

          const SizedBox(height: 24),

          EmployeeContact(
            emailController: _emailController,
            phoneController: _phoneController,
          ),

          const SizedBox(height: 24),

          EmployeeDepartment(
            departmentId: _departmentId,
            isActive: _isActive,
            onDepartmentChanged: (value) {
              setState(() {
                _departmentId = value;
              });
            },
            onStatusChanged: (value) {
              setState(() {
                _isActive = value;
              });
            },
          ),

          const SizedBox(height: 32),

          EmployeeActions(
            isEdit: _isEdit,
            onSave: _saveEmployee,
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}