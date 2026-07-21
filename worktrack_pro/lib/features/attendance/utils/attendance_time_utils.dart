import 'package:flutter/material.dart';

class AttendanceTimeUtils {
  AttendanceTimeUtils._();

  static Future<DateTime?> pickDate({
    required BuildContext context,
    required DateTime initialDate,
  }) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
  }

  static Future<TimeOfDay?> pickTime({
    required BuildContext context,
    TimeOfDay? initialTime,
  }) {
    return showTimePicker(
      context: context,
      initialTime:
      initialTime ?? TimeOfDay.now(),
    );
  }

  static DateTime combineDateAndTime({
    required DateTime date,
    required TimeOfDay time,
  }) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  static String formatTime(
      TimeOfDay? time,
      ) {
    if (time == null) {
      return '--:--';
    }

    final hour = time.hour
        .toString()
        .padLeft(2, '0');

    final minute = time.minute
        .toString()
        .padLeft(2, '0');

    return '$hour:$minute';
  }
}