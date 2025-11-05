import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/core/providers/fridge_provider.dart';
import 'package:fridge_app/core/providers/user_provider.dart';
import 'package:fridge_app/features/fridges/data/repositories/fridge_repository.dart';
import 'package:fridge_app/features/users/data/repositories/user_repository.dart';

class InviteMemberState {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  InviteMemberState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  InviteMemberState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return InviteMemberState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}

class InviteMemberController extends StateNotifier<InviteMemberState> {
  final UserRepository _userRepository;
  final FridgeRepository _fridgeRepository;

  InviteMemberController(this._userRepository, this._fridgeRepository)
    : super(InviteMemberState());

  Future<bool> inviteMember({
    required String fridgeId,
    required String currentUserId,
    required String email,
  }) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    );

    try {
      final userId = await _userRepository.getUserIdByEmail(email);

      if (userId == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'No user found with email: $email',
        );
        return false;
      }

      if (userId == currentUserId) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'You cannot invite yourself',
        );
        return false;
      }

      await _fridgeRepository.addMemberToFridge(
        fridgeId: fridgeId,
        userId: userId,
      );

      state = state.copyWith(
        isLoading: false,
        successMessage: 'Member invited successfully',
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to invite member: ${e.toString()}',
      );
      return false;
    }
  }

  void reset() {
    state = InviteMemberState();
  }
}

final inviteMemberControllerProvider =
    StateNotifierProvider<InviteMemberController, InviteMemberState>((ref) {
      final userRepository = ref.watch(userRepositoryProvider);
      final fridgeRepository = ref.watch(fridgeRepositoryProvider);
      return InviteMemberController(userRepository, fridgeRepository);
    });
