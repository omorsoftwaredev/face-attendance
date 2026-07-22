import 'package:flutter/material.dart';

class DashboardStatisticsGrid extends StatelessWidget {
  const DashboardStatisticsGrid({
    super.key,
    required this.totalEmployees,
    required this.totalDepartments,
    required this.totalDesignations,
    required this.totalShifts,
  });

  final int totalEmployees;
  final int totalDepartments;
  final int totalDesignations;
  final int totalShifts;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.45,
      children: [
        _StatisticsCard(
          icon: Icons.people_alt_rounded,
          title: 'Employees',
          value: totalEmployees.toString(),
          color: Colors.blue,
        ),
        _StatisticsCard(
          icon: Icons.apartment_rounded,
          title: 'Departments',
          value: totalDepartments.toString(),
          color: Colors.green,
        ),
        _StatisticsCard(
          icon: Icons.badge_rounded,
          title: 'Designations',
          value: totalDesignations.toString(),
          color: Colors.orange,
        ),
        _StatisticsCard(
          icon: Icons.schedule_rounded,
          title: 'Shifts',
          value: totalShifts.toString(),
          color: Colors.purple,
        ),
      ],
    );
  }
}

class _StatisticsCard extends StatelessWidget {
  const _StatisticsCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withValues(alpha: 0.15),
              child: Icon(
                icon,
                color: color,
                size: 26,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}