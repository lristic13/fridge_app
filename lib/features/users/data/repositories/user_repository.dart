import 'package:fridge_app/features/users/data/data_sources/firestore_user_data_source.dart';

class UserRepository {
  final FirestoreUserDataSource _dataSource;

  UserRepository({FirestoreUserDataSource? dataSource})
    : _dataSource = dataSource ?? FirestoreUserDataSource();

  Future<String?> getUserIdByEmail(String email) async {
    return await _dataSource.getUserIdByEmail(email);
  }
}
