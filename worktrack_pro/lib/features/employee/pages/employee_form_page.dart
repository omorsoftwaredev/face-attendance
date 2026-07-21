import 'package:flutter/material.dart';

import '../widgets/employee_form.dart';

class EmployeeFormPage extends StatelessWidget {
  const EmployeeFormPage({
    super.key,
    this.employeeId,
  });

  final String? employeeId;

  bool get isEdit => employeeId != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          isEdit
              ? 'Update Employee'
              : 'Create Employee',
        ),
      ),
      body: SafeArea(
        child: EmployeeForm(
          employeeId: employeeId,
        ),
      ),
    );
  }
}