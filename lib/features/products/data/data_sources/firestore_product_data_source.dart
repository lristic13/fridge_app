import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fridge_app/core/utils/app_exception.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';

class FirestoreProductDataSource {
  final FirebaseFirestore _firestore;
  static const String _collectionName = 'products';

  FirestoreProductDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<ProductModel>> getFridgeProducts(String fridgeId) {
    try {
      return _firestore
          .collection(_collectionName)
          .where('fridgeId', isEqualTo: fridgeId)
          .orderBy('timeStored', descending: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs
                .map((doc) => ProductModel.fromFirestore(doc))
                .toList();
          });
    } catch (e) {
      throw AppException('Failed to fetch products');
    }
  }

  Future<String> addProduct(ProductModel product) async {
    try {
      final docRef = await _firestore
          .collection(_collectionName)
          .add(product.toFirestore());
      return docRef.id;
    } catch (e) {
      throw AppException('Failed to add product');
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(product.id)
          .update(product.toFirestore());
    } catch (e) {
      throw AppException('Failed to update product');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection(_collectionName).doc(productId).delete();
    } catch (e) {
      throw AppException('Failed to delete product');
    }
  }

  Future<ProductModel?> getProduct(String productId) async {
    try {
      final doc =
          await _firestore.collection(_collectionName).doc(productId).get();

      if (!doc.exists) {
        return null;
      }

      return ProductModel.fromFirestore(doc);
    } catch (e) {
      throw AppException('Failed to fetch product');
    }
  }
}
