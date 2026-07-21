import 'package:flutter/material.dart';

import '../widgets/designation_form.dart';

class DesignationFormPage extends StatelessWidget {
  const DesignationFormPage({
    super.key,
    this.designationId,
    this.departmentId,
  });

  final String? designationId;
  final String? departmentId;

  bool get isEdit => designationId != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit
              ? 'Edit Designation'
              : 'Create Designation',
        ),
      ),
      body: SafeArea(
        child: DesignationForm(
          designationId: designationId,
          departmentId: departmentId,
        ),
      ),
    );
  }
}