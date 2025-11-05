import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/providers/auth_provider.dart';
import 'package:fridge_app/features/fridges/data/models/fridge_model.dart';
import 'package:fridge_app/features/fridges/data/repositories/fridge_repository.dart';

final fridgeRepositoryProvider = Provider<FridgeRepository>((ref) {
  return FridgeRepository();
});

final userFridgesProvider = StreamProvider<List<FridgeModel>>((ref) {
  final authState = ref.watch(currentUserProvider);
  final fridgeRepository = ref.watch(fridgeRepositoryProvider);

  return authState.when(
    data: (user) {
      if (user == null) {
        return Stream.value([]);
      }
      return fridgeRepository.getUserFridges(user.uid).asyncMap((data) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return data;
      });
    },
    loading: () => Stream.value([]),
    error: (_, __) => Stream.value([]),
  );
});
