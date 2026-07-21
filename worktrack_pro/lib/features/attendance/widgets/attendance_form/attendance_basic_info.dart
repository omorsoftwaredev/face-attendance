import 'package:flutter/material.dart';

class AttendanceBasicInfo extends StatelessWidget {
  const AttendanceBasicInfo({
    super.key,
    required this.selectedEmployeeId,
    required this.selectedShiftId,
    required this.attendanceDate,
    required this.employeeItems,
    required this.shiftItems,
    required this.onEmployeeChanged,
    required this.onShiftChanged,
    required this.onSelectDate,
  });

  final String? selectedEmployeeId;
  final String? selectedShiftId;
  final DateTime attendanceDate;

  final List<DropdownMenuItem<String>> employeeItems;
  final List<DropdownMenuItem<String>> shiftItems;

  final ValueChanged<String?> onEmployeeChanged;
  final ValueChanged<String?> onShiftChanged;

  final VoidCallback onSelectDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedEmployeeId,
              decoration: const InputDecoration(
                labelText: 'Employee',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.person_outline,
                ),
              ),
              items: employeeItems,
              onChanged: onEmployeeChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select an employee.';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: selectedShiftId,
              decoration: const InputDecoration(
                labelText: 'Shift',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.schedule_outlined,
                ),
              ),
              items: shiftItems,
              onChanged: onShiftChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a shift.';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            InkWell(
              onTap: onSelectDate,
              borderRadius: BorderRadius.circular(12),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Attendance Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.calendar_today_outlined,
                  ),
                ),
                child: Text(
                  '${attendanceDate.day.toString().padLeft(2, '0')}/'
                      '${attendanceDate.month.toString().padLeft(2, '0')}/'
                      '${attendanceDate.year}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}