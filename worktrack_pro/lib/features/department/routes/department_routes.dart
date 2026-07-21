import 'package:flutter/material.dart';

import '../models/department_model.dart';
import '../pages/department_form_page.dart';
import '../pages/department_list_page.dart';

class DepartmentRoutes {
  DepartmentRoutes._();

  static const String departmentList = '/departments';
  static const String createDepartment = '/departments/create';
  static const String editDepartment = '/departments/edit';

  static Route<dynamic> onGenerateRoute(
      RouteSettings settings,
      ) {
    switch (settings.name) {
      case departmentList:
        return MaterialPageRoute(
          builder: (_) => const DepartmentListPage(),
        );

      case createDepartment:
        return MaterialPageRoute(
          builder: (_) => const DepartmentFormPage(),
        );

      case editDepartment:
        final department =
        settings.arguments as DepartmentModel;

        return MaterialPageRoute(
          builder: (_) => DepartmentFormPage(
            departmentId: department.id,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text('404'),
            ),
            body: const Center(
              child: Text('Page Not Found'),
            ),
          ),
        );
    }
  }
}