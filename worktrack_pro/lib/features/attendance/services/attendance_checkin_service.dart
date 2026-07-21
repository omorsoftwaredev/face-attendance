import 'package:geolocator/geolocator.dart';

import '../../../core/models/attendance_model.dart';
import '../repositories/attendance_repository.dart';
import 'attendance_engine.dart';
import 'geofence_service.dart';
import 'location_service.dart';

class AttendanceCheckinService {
  AttendanceCheckinService({
    AttendanceRepository? repository,
    LocationService? locationService,
    GeofenceService? geofenceService,
  })  : _repository = repository ?? AttendanceRepository(),
        _locationService = locationService ?? LocationService(),
        _geofenceService = geofenceService ?? GeofenceService();

  final AttendanceRepository _repository;
  final LocationService _locationService;
  final GeofenceService _geofenceService;

  Future<AttendanceModel> checkIn({
    required AttendanceModel attendance,
    required double officeLatitude,
    required double officeLongitude,
    required double officeRadius,
    required DateTime shiftStart,
  }) async {
    final permission =
    await _locationService.requestPermission();

    if (!permission) {
      throw Exception(
        'Location permission denied.',
      );
    }

    final Position position =
    await _locationService.getCurrentLocation();

    final insideOffice =
    _geofenceService.isInsideOffice(
      officeLatitude: officeLatitude,
      officeLongitude: officeLongitude,
      employeeLatitude: position.latitude,
      employeeLongitude: position.longitude,
      allowedRadiusInMeters: officeRadius,
    );

    if (!insideOffice) {
      throw Exception(
        'You are outside the office area.',
      );
    }

    final existing =
    await _repository.getAttendanceByDate(
      employeeId: attendance.employeeId,
      attendanceDate: attendance.attendanceDate,
    );

    if (existing != null &&
        existing.checkInTime != null) {
      throw Exception(
        'Already checked in today.',
      );
    }

    final now = DateTime.now();

    final updatedAttendance =
    attendance.copyWith(
      checkInTime: now,
      checkInLatitude: position.latitude,
      checkInLongitude: position.longitude,
      lateMinutes: AttendanceEngine.lateMinutes(
        shiftStart: shiftStart,
        checkIn: now,
      ),
      updatedAt: now,
    );

    return await _repository.createAttendance(
      attendance: updatedAttendance,
    );
  }
}