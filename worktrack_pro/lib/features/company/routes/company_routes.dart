import 'package:flutter/material.dart';

import '../../../core/models/company_model.dart';
import '../pages/company_list_page.dart';
import '../pages/company_detail_page.dart';
import '../pages/company_form_page.dart';

class CompanyRoutes {
  static const String list =
      '/companies';

  static const String create =
      '/companies/create';

  static const String detail =
      '/companies/detail';

  static const String edit =
      '/companies/edit';

  static Route<dynamic>? generateRoute(
      RouteSettings settings,
      ) {
    switch (settings.name) {
      case list:
        return MaterialPageRoute(
          builder: (_) =>
          const CompanyListPage(),
        );

      case create:
        return MaterialPageRoute(
          builder: (_) =>
          const CompanyFormPage(),
        );

      case detail:
        final company =
        settings.arguments
        as CompanyModel;

        return MaterialPageRoute(
          builder: (_) =>
              CompanyDetailPage(
                company: company,
              ),
        );

      case edit:
        final company =
        settings.arguments
        as CompanyModel;

        return MaterialPageRoute(
          builder: (_) =>
              CompanyFormPage(
                company: company,
              ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(
                body: Center(
                  child: Text(
                    'Route not found: ${settings.name}',
                  ),
                ),
              ),
        );
    }
  }
}