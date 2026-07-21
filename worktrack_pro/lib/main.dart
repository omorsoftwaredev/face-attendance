import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:worktrack_pro/features/company/providers/company_provider.dart';
import 'package:worktrack_pro/features/splash/splash_page.dart';
import 'package:worktrack_pro/features/department/providers/department_provider.dart';
import 'package:worktrack_pro/features/designation/providers/designation_provider.dart';
import 'package:worktrack_pro/features/shift/providers/shift_provider.dart';
import 'package:worktrack_pro/features/attendance/providers/attendance_provider.dart';
import 'package:worktrack_pro/features/attendance/providers/attendance_dashboard_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bsynrvhpbbprxoyjopsn.supabase.co',
    anonKey: 'sb_publishable_eXlBZd3lWhLCcbI6E1wITA_myXSPEf8',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CompanyProvider>(
          create: (_) => CompanyProvider(),
        ),

        ChangeNotifierProvider<DepartmentProvider>(
          create: (_) => DepartmentProvider(),
        ),
        ChangeNotifierProvider<DesignationProvider>(
          create: (_) => DesignationProvider(),
        ),
        ChangeNotifierProvider<ShiftProvider>(
          create: (_) => ShiftProvider(),
        ),
        ChangeNotifierProvider<AttendanceProvider>(
          create: (_) => AttendanceProvider(),
        ),
        ChangeNotifierProvider<AttendanceDashboardProvider>(
          create: (_) => AttendanceDashboardProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WorkTrack Pro',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.indigo,
          scaffoldBackgroundColor: const Color(0xFFF7F8FA),
          appBarTheme: const AppBarTheme(
            centerTitle: false,
            elevation: 0,
          ),
          cardTheme: const CardThemeData(
            elevation: 1,
            margin: EdgeInsets.zero,
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}