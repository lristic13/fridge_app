import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fridge_app/core/utils/app_exception.dart';

class FirestoreUserDataSource {
  final FirebaseFirestore _firestore;
  static const String _collectionName = 'users';

  FirestoreUserDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createUser({
    required String userId,
    required String email,
  }) async {
    try {
      await _firestore.collection(_collectionName).doc(userId).set({
        'email': email.toLowerCase().trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw AppException('Failed to create user');
    }
  }

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

  Future<Map<String, String>> getUserEmailsByIds(List<String> userIds) async {
    if (userIds.isEmpty) return {};

    try {
      final results = <String, String>{};

      // Firestore 'whereIn' limited to 10 items, so batch if needed
      for (var i = 0; i < userIds.length; i += 10) {
        final batch = userIds.skip(i).take(10).toList();
        final snapshot =
            await _firestore
                .collection(_collectionName)
                .where(FieldPath.documentId, whereIn: batch)
                .get();

        for (final doc in snapshot.docs) {
          final data = doc.data();
          results[doc.id] = data['email'] as String? ?? 'Unknown';
        }
      }

      return results;
    } catch (e) {
      throw AppException('Failed to fetch users');
    }
  }
}
