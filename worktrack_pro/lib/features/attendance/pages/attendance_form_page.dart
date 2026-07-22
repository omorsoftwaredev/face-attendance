import 'package:flutter/material.dart';

import '../widgets/attendance_form.dart';

class AttendanceFormPage extends StatelessWidget {
  const AttendanceFormPage({
    super.key,
    this.attendanceId,
  });

  final String? attendanceId;

  bool get isEdit => attendanceId != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          isEdit ? 'Edit Attendance' : 'Add Attendance',
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SizedBox.expand(
          child: AttendanceForm(
            attendanceId: attendanceId,
          ),
        ),
      ),
    );
  }
}
