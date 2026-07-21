import 'package:flutter/material.dart';

import '../models/shift_model.dart';
import '../pages/shift_form_page.dart';
import '../pages/shift_list_page.dart';

class ShiftRoutes {
  ShiftRoutes._();

  static const String shiftList = '/shifts';
  static const String createShift = '/shifts/create';
  static const String editShift = '/shifts/edit';

  static Route<dynamic> onGenerateRoute(
      RouteSettings settings,
      ) {
    switch (settings.name) {
      case shiftList:
        return MaterialPageRoute(
          builder: (_) => const ShiftListPage(),
        );

      case createShift:
        return MaterialPageRoute(
          builder: (_) => const ShiftFormPage(),
        );

      case editShift:
        final shift = settings.arguments as ShiftModel;

        return MaterialPageRoute(
          builder: (_) => ShiftFormPage(
            shiftId: shift.id,
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