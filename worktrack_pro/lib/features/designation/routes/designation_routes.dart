import 'package:flutter/material.dart';

import '../models/designation_model.dart';
import '../pages/designation_form_page.dart';
import '../pages/designation_list_page.dart';

class DesignationRoutes {
  DesignationRoutes._();

  static const String designationList = '/designations';
  static const String createDesignation = '/designations/create';
  static const String editDesignation = '/designations/edit';

  static Route<dynamic> onGenerateRoute(
      RouteSettings settings,
      ) {
    switch (settings.name) {
      case designationList:
        return MaterialPageRoute(
          builder: (_) => const DesignationListPage(),
        );

      case createDesignation:
        return MaterialPageRoute(
          builder: (_) => const DesignationFormPage(),
        );

      case editDesignation:
        final designation =
        settings.arguments as DesignationModel;

        return MaterialPageRoute(
          builder: (_) => DesignationFormPage(
            designationId: designation.id,
            departmentId: designation.departmentId,
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