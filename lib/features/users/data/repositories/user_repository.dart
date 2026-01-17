import 'package:fridge_app/features/users/data/data_sources/firestore_user_data_source.dart';

class UserRepository {
  final FirestoreUserDataSource _dataSource;

  UserRepository({FirestoreUserDataSource? dataSource})
    : _dataSource = dataSource ?? FirestoreUserDataSource();

  Future<void> createUser({
    required String userId,
    required String email,
  }) async {
    await _dataSource.createUser(userId: userId, email: email);
  }

  Future<String?> getUserIdByEmail(String email) async {
    return await _dataSource.getUserIdByEmail(email);
  }

  Future<Map<String, String>> getUserEmailsByIds(List<String> userIds) async {
    return await _dataSource.getUserEmailsByIds(userIds);
  }
}
