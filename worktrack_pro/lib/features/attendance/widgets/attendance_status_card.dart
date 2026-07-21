import 'package:flutter/material.dart';

class AttendanceStatusCard extends StatelessWidget {
  const AttendanceStatusCard({
    super.key,
    required this.status,
    required this.workedMinutes,
    required this.lateMinutes,
    required this.overtimeMinutes,
  });

  final String status;
  final int workedMinutes;
  final int lateMinutes;
  final int overtimeMinutes;

  String _formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;

    return '${hours}h ${mins}m';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.fact_check_outlined,
                color: Colors.green,
              ),
              title: const Text(
                'Attendance Status',
              ),
              subtitle: Text(status),
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text(
                'Worked Time',
              ),
              trailing: Text(
                _formatMinutes(workedMinutes),
              ),
            ),

            ListTile(
              leading: const Icon(
                Icons.timer_off_outlined,
              ),
              title: const Text(
                'Late',
              ),
              trailing: Text(
                _formatMinutes(lateMinutes),
              ),
            ),

            ListTile(
              leading: const Icon(
                Icons.more_time_outlined,
              ),
              title: const Text(
                'Overtime',
              ),
              trailing: Text(
                _formatMinutes(overtimeMinutes),
              ),
            ),
          ],
        ),
      ),
    );
  }
}