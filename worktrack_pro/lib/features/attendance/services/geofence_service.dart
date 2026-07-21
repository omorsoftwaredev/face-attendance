import 'location_service.dart';

class GeofenceService {
  GeofenceService({
    LocationService? locationService,
  }) : _locationService =
      locationService ?? LocationService();

  final LocationService _locationService;

  /// Returns true if employee is inside office radius.
  bool isInsideOffice({
    required double officeLatitude,
    required double officeLongitude,
    required double employeeLatitude,
    required double employeeLongitude,
    required double allowedRadiusInMeters,
  }) {
    final distance =
    _locationService.distanceInMeters(
      startLatitude: officeLatitude,
      startLongitude: officeLongitude,
      endLatitude: employeeLatitude,
      endLongitude: employeeLongitude,
    );

    return distance <= allowedRadiusInMeters;
  }

  /// Returns distance from office in meters.
  double distanceFromOffice({
    required double officeLatitude,
    required double officeLongitude,
    required double employeeLatitude,
    required double employeeLongitude,
  }) {
    return _locationService.distanceInMeters(
      startLatitude: officeLatitude,
      startLongitude: officeLongitude,
      endLatitude: employeeLatitude,
      endLongitude: employeeLongitude,
    );
  }
}