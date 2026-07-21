import 'package:flutter/material.dart';

import '../widgets/shift_form.dart';

class ShiftFormPage extends StatelessWidget {
  const ShiftFormPage({
    super.key,
    this.shiftId,
  });

  final String? shiftId;

  bool get isEdit => shiftId != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit
              ? 'Edit Shift'
              : 'Create Shift',
        ),
      ),
      body: SafeArea(
        child: ShiftForm(
          shiftId: shiftId,
        ),
      ),
    );
  }
}