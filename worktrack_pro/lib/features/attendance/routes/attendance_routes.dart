import 'package:flutter/material.dart';

import '../../../core/models/attendance_model.dart';
import '../pages/attendance_form_page.dart';
import '../pages/attendance_list_page.dart';

class AttendanceRoutes {
  AttendanceRoutes._();

  static const String attendanceList = '/attendances';
  static const String createAttendance = '/attendances/create';
  static const String editAttendance = '/attendances/edit';

  static Route<dynamic> onGenerateRoute(
      RouteSettings settings,
      ) {
    switch (settings.name) {
      case attendanceList:
        return MaterialPageRoute(
          builder: (_) => const AttendanceListPage(),
        );

      case createAttendance:
        return MaterialPageRoute(
          builder: (_) => const AttendanceFormPage(),
        );

      case editAttendance:
        final attendance =
        settings.arguments as AttendanceModel;

        return MaterialPageRoute(
          builder: (_) => AttendanceFormPage(
            attendanceId: attendance.id,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text('404'),
            ),
            body: const Center(
              child: Text(
                'Page Not Found',
              ),
            ),
          ),
        );
    }
  }
}