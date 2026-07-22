import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../attendance/providers/attendance_dashboard_provider.dart';
import '../attendance/widgets/attendance_dashboard_card.dart';
import '../attendance/widgets/attendance_summary_card.dart';
import '../auth/login_page.dart';
import 'widgets/dashboard_company_selector.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Future<void> logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    final dashboard =
    context.watch<AttendanceDashboardProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Future Dashboard Refresh
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            /// User Information
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(
                  user?.email ?? '',
                ),
                subtitle: const Text(
                  'Welcome to WorkTrack Pro',
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Attendance Dashboard
            AttendanceDashboardCard(
              totalEmployees:
              dashboard.totalEmployees,
              presentEmployees:
              dashboard.presentEmployees,
              absentEmployees:
              dashboard.absentEmployees,
              lateEmployees:
              dashboard.lateEmployees,
            ),

            const SizedBox(height: 16),

            /// Attendance Summary
            AttendanceSummaryCard(
              presentCount:
              dashboard.presentEmployees,
              absentCount:
              dashboard.absentEmployees,
              lateCount:
              dashboard.lateEmployees,
              attendanceRate:
              dashboard.attendanceRate,
            ),

            const SizedBox(height: 16),

            /// Company Selector
            const DashboardCompanySelector(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}