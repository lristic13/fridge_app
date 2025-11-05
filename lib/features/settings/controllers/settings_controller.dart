import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/providers/fridge_provider.dart';
import 'package:fridge_app/features/fridges/data/models/fridge_model.dart';
import 'package:fridge_app/features/fridges/data/repositories/fridge_repository.dart';

class SettingsState {
  final bool isLoading;
  final String? errorMessage;

  SettingsState({this.isLoading = false, this.errorMessage});

  SettingsState copyWith({bool? isLoading, String? errorMessage}) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class SettingsController extends StateNotifier<SettingsState> {
  final FridgeRepository _fridgeRepository;

  SettingsController(this._fridgeRepository) : super(SettingsState());

  Future<bool> updateFridgeName({
    required FridgeModel fridge,
    required String newName,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final updatedFridge = fridge.copyWith(name: newName);
      await _fridgeRepository.updateFridge(updatedFridge);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to update fridge name: ${e.toString()}',
      );
      return false;
    }
  }
}

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsState>((ref) {
      final fridgeRepository = ref.watch(fridgeRepositoryProvider);
      return SettingsController(fridgeRepository);
    });
