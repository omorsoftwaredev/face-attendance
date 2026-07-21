import 'package:flutter/material.dart';

import '../widgets/department_form.dart';

class DepartmentFormPage extends StatelessWidget {
  const DepartmentFormPage({
    super.key,
    this.departmentId,
  });

  final String? departmentId;

  bool get isEdit => departmentId != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit
              ? 'Edit Department'
              : 'Create Department',
        ),
      ),
      body: SafeArea(
        child: DepartmentForm(
          departmentId: departmentId,
        ),
      ),
    );
  }
}