import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fridge_app/core/utils/app_exception.dart';

class FirestoreUserDataSource {
  final FirebaseFirestore _firestore;
  static const String _collectionName = 'users';

  FirestoreUserDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<String?> getUserIdByEmail(String email) async {
    try {
      final snapshot =
          await _firestore
              .collection(_collectionName)
              .where('email', isEqualTo: email.toLowerCase().trim())
              .limit(1)
              .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      return snapshot.docs.first.id;
    } catch (e) {
      throw AppException('Failed to find user');
    }
  }
}
