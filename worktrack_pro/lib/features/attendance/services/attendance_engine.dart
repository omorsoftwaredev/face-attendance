class AttendanceEngine {
  AttendanceEngine._();

  /// Calculate worked minutes.
  static int workedMinutes({
    required DateTime checkIn,
    required DateTime checkOut,
  }) {
    final minutes =
        checkOut.difference(checkIn).inMinutes;

    return minutes < 0 ? 0 : minutes;
  }

  /// Calculate late minutes.
  static int lateMinutes({
    required DateTime shiftStart,
    required DateTime checkIn,
  }) {
    if (!checkIn.isAfter(shiftStart)) {
      return 0;
    }

    return checkIn
        .difference(shiftStart)
        .inMinutes;
  }

  /// Calculate early leave minutes.
  static int earlyLeaveMinutes({
    required DateTime shiftEnd,
    required DateTime checkOut,
  }) {
    if (!checkOut.isBefore(shiftEnd)) {
      return 0;
    }

    return shiftEnd
        .difference(checkOut)
        .inMinutes;
  }

  /// Calculate overtime minutes.
  static int overtimeMinutes({
    required DateTime shiftEnd,
    required DateTime checkOut,
  }) {
    if (!checkOut.isAfter(shiftEnd)) {
      return 0;
    }

    return checkOut
        .difference(shiftEnd)
        .inMinutes;
  }

  /// Check if employee is late.
  static bool isLate({
    required DateTime shiftStart,
    required DateTime checkIn,
  }) {
    return checkIn.isAfter(shiftStart);
  }

  /// Check if employee left early.
  static bool leftEarly({
    required DateTime shiftEnd,
    required DateTime checkOut,
  }) {
    return checkOut.isBefore(shiftEnd);
  }

  /// Check overtime.
  static bool hasOvertime({
    required DateTime shiftEnd,
    required DateTime checkOut,
  }) {
    return checkOut.isAfter(shiftEnd);
  }
}