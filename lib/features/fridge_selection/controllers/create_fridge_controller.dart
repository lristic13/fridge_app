import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/providers/fridge_provider.dart';
import 'package:fridge_app/features/fridges/data/models/fridge_model.dart';
import 'package:fridge_app/features/fridges/data/repositories/fridge_repository.dart';

class CreateFridgeState {
  final bool isLoading;
  final String? errorMessage;

  CreateFridgeState({this.isLoading = false, this.errorMessage});

  CreateFridgeState copyWith({bool? isLoading, String? errorMessage}) {
    return CreateFridgeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class CreateFridgeController extends StateNotifier<CreateFridgeState> {
  final FridgeRepository _fridgeRepository;

  CreateFridgeController(this._fridgeRepository) : super(CreateFridgeState());

  Future<bool> createFridge({
    required String userId,
    required String name,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final fridge = FridgeModel(
        id: '',
        name: name,
        ownerId: userId,
        memberIds: [],
        createdAt: DateTime.now(),
      );

      await _fridgeRepository.addFridge(fridge);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to create fridge: ${e.toString()}',
      );
      return false;
    }
  }
}

final createFridgeControllerProvider =
    StateNotifierProvider<CreateFridgeController, CreateFridgeState>((ref) {
      final fridgeRepository = ref.watch(fridgeRepositoryProvider);
      return CreateFridgeController(fridgeRepository);
    });
