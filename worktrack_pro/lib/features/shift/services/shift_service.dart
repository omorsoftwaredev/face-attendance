import '../models/shift_model.dart';
import '../repositories/shift_repository.dart';

class ShiftService {
  ShiftService({
    ShiftRepository? repository,
  }) : _repository = repository ?? ShiftRepository();

  final ShiftRepository _repository;

  Future<List<ShiftModel>> getShifts({
    required String companyId,
  }) async {
    return await _repository.getShifts(
      companyId: companyId,
    );
  }

  Future<List<ShiftModel>> getActiveShifts({
    required String companyId,
  }) async {
    return await _repository.getActiveShifts(
      companyId: companyId,
    );
  }

  Future<ShiftModel?> getShiftById(
      String id,
      ) async {
    return await _repository.getShiftById(id);
  }

  Future<ShiftModel> createShift({
    required ShiftModel shift,
  }) async {
    final exists = await _repository.shiftNameExists(
      companyId: shift.companyId,
      shiftName: shift.shiftName,
    );

    if (exists) {
      throw Exception(
        'Shift already exists.',
      );
    }

    return await _repository.createShift(
      shift: shift,
    );
  }

  Future<ShiftModel> updateShift({
    required ShiftModel shift,
  }) async {
    final exists = await _repository.shiftNameExists(
      companyId: shift.companyId,
      shiftName: shift.shiftName,
      excludeId: shift.id,
    );

    if (exists) {
      throw Exception(
        'Shift already exists.',
      );
    }

    return await _repository.updateShift(
      shift: shift,
    );
  }

  Future<void> deleteShift(
      String id,
      ) async {
    await _repository.deleteShift(id);
  }
}