import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/providers/fridge_provider.dart';
import 'package:fridge_app/features/fridges/data/models/fridge_model.dart';
import 'package:fridge_app/features/fridges/data/repositories/fridge_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectedFridgeNotifier extends StateNotifier<FridgeModel?> {
  final FridgeRepository _fridgeRepository;
  static const String _selectedFridgeIdKey = 'selected_fridge_id';

  SelectedFridgeNotifier(this._fridgeRepository) : super(null);

  Future<void> loadSelectedFridge() async {
    final prefs = await SharedPreferences.getInstance();
    final fridgeId = prefs.getString(_selectedFridgeIdKey);

    if (fridgeId != null) {
      try {
        final fridge = await _fridgeRepository.getFridge(fridgeId);
        state = fridge;
      } catch (e) {
        await prefs.remove(_selectedFridgeIdKey);
        state = null;
      }
    }
  }

  Future<void> setSelectedFridge(FridgeModel fridge) async {
    state = fridge;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedFridgeIdKey, fridge.id);
  }

  Future<void> clearSelectedFridge() async {
    state = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_selectedFridgeIdKey);
  }
}

final selectedFridgeProvider =
    StateNotifierProvider<SelectedFridgeNotifier, FridgeModel?>((ref) {
      final fridgeRepository = ref.watch(fridgeRepositoryProvider);
      return SelectedFridgeNotifier(fridgeRepository);
    });

/// Provider that only tracks whether a fridge is selected (not the full object).
/// Used by the router to avoid rebuilding when fridge details change.
final hasFridgeSelectedProvider = Provider<bool>((ref) {
  return ref.watch(selectedFridgeProvider) != null;
});
