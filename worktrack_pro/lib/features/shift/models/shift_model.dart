class ShiftModel {
  final String id;
  final String companyId;

  final String shiftName;

  final String startTime;
  final String endTime;

  final int lateGraceMinutes;
  final int earlyLeaveGraceMinutes;
  final int halfDayMinutes;

  final bool isNightShift;
  final bool isActive;

  final DateTime createdAt;
  final DateTime updatedAt;

  const ShiftModel({
    required this.id,
    required this.companyId,
    required this.shiftName,
    required this.startTime,
    required this.endTime,
    required this.lateGraceMinutes,
    required this.earlyLeaveGraceMinutes,
    required this.halfDayMinutes,
    required this.isNightShift,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShiftModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return ShiftModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      shiftName: json['shift_name'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      lateGraceMinutes:
      json['late_grace_minutes'] as int,
      earlyLeaveGraceMinutes:
      json['early_leave_grace_minutes'] as int,
      halfDayMinutes:
      json['half_day_minutes'] as int,
      isNightShift:
      json['is_night_shift'] as bool,
      isActive:
      json['is_active'] as bool,
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
      'shift_name': shiftName,
      'start_time': startTime,
      'end_time': endTime,
      'late_grace_minutes':
      lateGraceMinutes,
      'early_leave_grace_minutes':
      earlyLeaveGraceMinutes,
      'half_day_minutes':
      halfDayMinutes,
      'is_night_shift':
      isNightShift,
      'is_active':
      isActive,
      'created_at':
      createdAt.toIso8601String(),
      'updated_at':
      updatedAt.toIso8601String(),
    };
  }

  ShiftModel copyWith({
    String? id,
    String? companyId,
    String? shiftName,
    String? startTime,
    String? endTime,
    int? lateGraceMinutes,
    int? earlyLeaveGraceMinutes,
    int? halfDayMinutes,
    bool? isNightShift,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ShiftModel(
      id: id ?? this.id,
      companyId:
      companyId ?? this.companyId,
      shiftName:
      shiftName ?? this.shiftName,
      startTime:
      startTime ?? this.startTime,
      endTime:
      endTime ?? this.endTime,
      lateGraceMinutes:
      lateGraceMinutes ??
          this.lateGraceMinutes,
      earlyLeaveGraceMinutes:
      earlyLeaveGraceMinutes ??
          this.earlyLeaveGraceMinutes,
      halfDayMinutes:
      halfDayMinutes ??
          this.halfDayMinutes,
      isNightShift:
      isNightShift ??
          this.isNightShift,
      isActive:
      isActive ?? this.isActive,
      createdAt:
      createdAt ?? this.createdAt,
      updatedAt:
      updatedAt ?? this.updatedAt,
    );
  }
}