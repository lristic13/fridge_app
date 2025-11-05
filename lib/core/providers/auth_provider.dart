import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/features/auth/data/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final currentUserProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(currentUserProvider);
  return authState.when(
    data: (user) => user != null,
    loading: () => false,
    error: (_, __) => false,
  );
});
