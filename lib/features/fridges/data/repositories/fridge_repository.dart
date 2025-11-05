import 'package:fridge_app/features/fridges/data/data_sources/firestore_fridge_data_source.dart';
import 'package:fridge_app/features/fridges/data/models/fridge_model.dart';

class FridgeRepository {
  final FirestoreFridgeDataSource _dataSource;

  FridgeRepository({FirestoreFridgeDataSource? dataSource})
    : _dataSource = dataSource ?? FirestoreFridgeDataSource();

  Stream<List<FridgeModel>> getUserFridges(String userId) {
    return _dataSource.getUserFridges(userId);
  }

  Future<String> addFridge(FridgeModel fridge) async {
    return await _dataSource.addFridge(fridge);
  }

  Future<void> updateFridge(FridgeModel fridge) async {
    await _dataSource.updateFridge(fridge);
  }

  Future<void> deleteFridge(String fridgeId) async {
    await _dataSource.deleteFridge(fridgeId);
  }

  Future<FridgeModel?> getFridge(String fridgeId) async {
    return await _dataSource.getFridge(fridgeId);
  }

  Future<void> addMemberToFridge({
    required String fridgeId,
    required String userId,
  }) async {
    await _dataSource.addMemberToFridge(fridgeId: fridgeId, userId: userId);
  }
}
