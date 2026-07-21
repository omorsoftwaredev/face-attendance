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
        title: Text(
          isEdit
              ? 'Edit Attendance'
              : 'Add Attendance',
        ),
      ),
      body: SafeArea(
        child: AttendanceForm(
          attendanceId: attendanceId,
        ),
      ),
    );
  }
}