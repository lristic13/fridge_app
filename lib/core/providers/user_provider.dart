import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_app/features/users/data/repositories/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});
