import 'package:flutter/material.dart';

import '../../../core/models/employee_model.dart';
import '../pages/employee_detail_page.dart';
import '../pages/employee_form_page.dart';
import '../pages/employee_list_page.dart';

class EmployeeRoutes {
  EmployeeRoutes._();

  static const String employeeList = '/employees';
  static const String createEmployee = '/employees/create';
  static const String editEmployee = '/employees/edit';
  static const String employeeDetail = '/employees/detail';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case employeeList:
        return MaterialPageRoute(
          builder: (_) => const EmployeeListPage(),
        );

      case createEmployee:
        return MaterialPageRoute(
          builder: (_) => const EmployeeFormPage(),
        );

      case editEmployee:
        final employeeId = settings.arguments as String;

        return MaterialPageRoute(
          builder: (_) => EmployeeFormPage(
            employeeId: employeeId,
          ),
        );

      case employeeDetail:
        final employee = settings.arguments as EmployeeModel;

        return MaterialPageRoute(
          builder: (_) => EmployeeDetailPage(
            employee: employee,
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