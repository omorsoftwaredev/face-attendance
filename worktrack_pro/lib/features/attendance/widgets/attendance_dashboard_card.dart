import 'package:flutter/material.dart';

class AttendanceDashboardCard extends StatelessWidget {
  const AttendanceDashboardCard({
    super.key,
    required this.totalEmployees,
    required this.presentEmployees,
    required this.absentEmployees,
    required this.lateEmployees,
  });

  final int totalEmployees;
  final int presentEmployees;
  final int absentEmployees;
  final int lateEmployees;

  @override
  Widget build(BuildContext context) {
    final attendanceRate = totalEmployees == 0
        ? 0.0
        : (presentEmployees / totalEmployees) * 100;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today Attendance',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge,
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _Item(
                    title: 'Employees',
                    value: totalEmployees.toString(),
                    icon: Icons.people_alt_outlined,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: _Item(
                    title: 'Present',
                    value: presentEmployees.toString(),
                    icon: Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _Item(
                    title: 'Absent',
                    value: absentEmployees.toString(),
                    icon: Icons.cancel_outlined,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: _Item(
                    title: 'Late',
                    value: lateEmployees.toString(),
                    icon: Icons.access_time,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            LinearProgressIndicator(
              value: attendanceRate / 100,
              minHeight: 8,
              borderRadius:
              BorderRadius.circular(12),
            ),

            const SizedBox(height: 8),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${attendanceRate.toStringAsFixed(1)}% Attendance',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(title),
          ],
        ),
      ),
    );
  }
}