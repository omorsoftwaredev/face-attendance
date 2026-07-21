import 'package:flutter/material.dart';

class AttendanceTimeSection extends StatelessWidget {
  const AttendanceTimeSection({
    super.key,
    required this.checkInTime,
    required this.checkOutTime,
    required this.onSelectCheckInTime,
    required this.onSelectCheckOutTime,
  });

  final TimeOfDay? checkInTime;
  final TimeOfDay? checkOutTime;

  final VoidCallback onSelectCheckInTime;
  final VoidCallback onSelectCheckOutTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            InkWell(
              onTap: onSelectCheckInTime,
              borderRadius: BorderRadius.circular(12),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Check In Time',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.login,
                  ),
                ),
                child: Text(
                  checkInTime == null
                      ? 'Select Check In Time'
                      : checkInTime!.format(context),
                ),
              ),
            ),

            const SizedBox(height: 16),

            InkWell(
              onTap: onSelectCheckOutTime,
              borderRadius: BorderRadius.circular(12),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Check Out Time',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.logout,
                  ),
                ),
                child: Text(
                  checkOutTime == null
                      ? 'Select Check Out Time'
                      : checkOutTime!.format(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}