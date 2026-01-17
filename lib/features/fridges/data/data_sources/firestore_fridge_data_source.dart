import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fridge_app/core/utils/app_exception.dart';
import 'package:fridge_app/features/fridges/data/models/fridge_model.dart';

class FirestoreFridgeDataSource {
  final FirebaseFirestore _firestore;
  static const String _collectionName = 'fridges';

  FirestoreFridgeDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<FridgeModel>> getUserFridges(String userId) {
    try {
      return _firestore
          .collection(_collectionName)
          .where('ownerId', isEqualTo: userId)
          .snapshots()
          .asyncMap((ownerSnapshot) async {
            final ownerFridges =
                ownerSnapshot.docs
                    .map((doc) => FridgeModel.fromFirestore(doc))
                    .toList();

            final memberSnapshot =
                await _firestore
                    .collection(_collectionName)
                    .where('memberIds', arrayContains: userId)
                    .get();

            final memberFridges =
                memberSnapshot.docs
                    .map((doc) => FridgeModel.fromFirestore(doc))
                    .toList();

            final allFridges = [...ownerFridges, ...memberFridges];
            final uniqueFridges = <String, FridgeModel>{};
            for (final fridge in allFridges) {
              uniqueFridges[fridge.id] = fridge;
            }

            return uniqueFridges.values.toList()
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
          });
    } catch (e) {
      throw AppException('Failed to fetch fridges');
    }
  }

  Future<String> addFridge(FridgeModel fridge) async {
    try {
      final docRef = await _firestore
          .collection(_collectionName)
          .add(fridge.toFirestore());
      return docRef.id;
    } catch (e) {
      throw AppException('Failed to create fridge');
    }
  }

  Future<void> updateFridge(FridgeModel fridge) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(fridge.id)
          .update(fridge.toFirestore());
    } catch (e) {
      throw AppException('Failed to update fridge');
    }
  }

  Future<void> deleteFridge(String fridgeId) async {
    try {
      await _firestore.collection(_collectionName).doc(fridgeId).delete();
    } catch (e) {
      throw AppException('Failed to delete fridge');
    }
  }

  Future<FridgeModel?> getFridge(String fridgeId) async {
    try {
      final doc =
          await _firestore.collection(_collectionName).doc(fridgeId).get();

      if (!doc.exists) {
        return null;
      }

      return FridgeModel.fromFirestore(doc);
    } catch (e) {
      throw AppException('Failed to fetch fridge');
    }
  }

  Future<void> addMemberToFridge({
    required String fridgeId,
    required String userId,
  }) async {
    try {
      await _firestore.collection(_collectionName).doc(fridgeId).update({
        'memberIds': FieldValue.arrayUnion([userId]),
      });
    } catch (e) {
      throw AppException('Failed to add member to fridge');
    }
  }

  Future<void> removeMemberFromFridge({
    required String fridgeId,
    required String userId,
  }) async {
    try {
      await _firestore.collection(_collectionName).doc(fridgeId).update({
        'memberIds': FieldValue.arrayRemove([userId]),
      });
    } catch (e) {
      throw AppException('Failed to remove member from fridge');
    }
  }
}
