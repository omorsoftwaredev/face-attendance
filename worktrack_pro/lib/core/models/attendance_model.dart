class AttendanceModel {
  final String id;
  final String companyId;
  final String employeeId;
  final String? shiftId;

  final DateTime attendanceDate;

  final DateTime? checkInTime;
  final DateTime? checkOutTime;

  final double? checkInLatitude;
  final double? checkInLongitude;

  final double? checkOutLatitude;
  final double? checkOutLongitude;

  final int workedMinutes;
  final int lateMinutes;
  final int earlyLeaveMinutes;
  final int overtimeMinutes;

  final String attendanceStatus;
  final String? notes;

  final DateTime createdAt;
  final DateTime updatedAt;

  const AttendanceModel({
    required this.id,
    required this.companyId,
    required this.employeeId,
    this.shiftId,
    required this.attendanceDate,
    this.checkInTime,
    this.checkOutTime,
    this.checkInLatitude,
    this.checkInLongitude,
    this.checkOutLatitude,
    this.checkOutLongitude,
    required this.workedMinutes,
    required this.lateMinutes,
    required this.earlyLeaveMinutes,
    required this.overtimeMinutes,
    required this.attendanceStatus,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AttendanceModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return AttendanceModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      employeeId: json['employee_id'] as String,
      shiftId: json['shift_id'] as String?,
      attendanceDate: DateTime.parse(
        json['attendance_date'] as String,
      ),
      checkInTime: json['check_in_time'] != null
          ? DateTime.parse(
        json['check_in_time'] as String,
      )
          : null,
      checkOutTime: json['check_out_time'] != null
          ? DateTime.parse(
        json['check_out_time'] as String,
      )
          : null,
      checkInLatitude:
      (json['check_in_latitude'] as num?)
          ?.toDouble(),
      checkInLongitude:
      (json['check_in_longitude'] as num?)
          ?.toDouble(),
      checkOutLatitude:
      (json['check_out_latitude'] as num?)
          ?.toDouble(),
      checkOutLongitude:
      (json['check_out_longitude'] as num?)
          ?.toDouble(),
      workedMinutes:
      json['worked_minutes'] as int? ?? 0,
      lateMinutes:
      json['late_minutes'] as int? ?? 0,
      earlyLeaveMinutes:
      json['early_leave_minutes'] as int? ?? 0,
      overtimeMinutes:
      json['overtime_minutes'] as int? ?? 0,
      attendanceStatus:
      json['attendance_status'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(
        json['created_at'] as String,
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'employee_id': employeeId,
      'shift_id': shiftId,
      'attendance_date':
      attendanceDate.toIso8601String(),
      'check_in_time':
      checkInTime?.toIso8601String(),
      'check_out_time':
      checkOutTime?.toIso8601String(),
      'check_in_latitude':
      checkInLatitude,
      'check_in_longitude':
      checkInLongitude,
      'check_out_latitude':
      checkOutLatitude,
      'check_out_longitude':
      checkOutLongitude,
      'worked_minutes':
      workedMinutes,
      'late_minutes':
      lateMinutes,
      'early_leave_minutes':
      earlyLeaveMinutes,
      'overtime_minutes':
      overtimeMinutes,
      'attendance_status':
      attendanceStatus,
      'notes': notes,
      'created_at':
      createdAt.toIso8601String(),
      'updated_at':
      updatedAt.toIso8601String(),
    };
  }

  AttendanceModel copyWith({
    String? id,
    String? companyId,
    String? employeeId,
    String? shiftId,
    DateTime? attendanceDate,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    double? checkInLatitude,
    double? checkInLongitude,
    double? checkOutLatitude,
    double? checkOutLongitude,
    int? workedMinutes,
    int? lateMinutes,
    int? earlyLeaveMinutes,
    int? overtimeMinutes,
    String? attendanceStatus,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      employeeId: employeeId ?? this.employeeId,
      shiftId: shiftId ?? this.shiftId,
      attendanceDate:
      attendanceDate ?? this.attendanceDate,
      checkInTime:
      checkInTime ?? this.checkInTime,
      checkOutTime:
      checkOutTime ?? this.checkOutTime,
      checkInLatitude:
      checkInLatitude ??
          this.checkInLatitude,
      checkInLongitude:
      checkInLongitude ??
          this.checkInLongitude,
      checkOutLatitude:
      checkOutLatitude ??
          this.checkOutLatitude,
      checkOutLongitude:
      checkOutLongitude ??
          this.checkOutLongitude,
      workedMinutes:
      workedMinutes ?? this.workedMinutes,
      lateMinutes:
      lateMinutes ?? this.lateMinutes,
      earlyLeaveMinutes:
      earlyLeaveMinutes ??
          this.earlyLeaveMinutes,
      overtimeMinutes:
      overtimeMinutes ??
          this.overtimeMinutes,
      attendanceStatus:
      attendanceStatus ??
          this.attendanceStatus,
      notes: notes ?? this.notes,
      createdAt:
      createdAt ?? this.createdAt,
      updatedAt:
      updatedAt ?? this.updatedAt,
    );
  }
}