import 'package:fridge_app/features/products/data/data_sources/firestore_product_data_source.dart';
import 'package:fridge_app/features/products/data/models/product_model.dart';

class ProductRepository {
  final FirestoreProductDataSource _dataSource;

  ProductRepository({FirestoreProductDataSource? dataSource})
    : _dataSource = dataSource ?? FirestoreProductDataSource();

  Stream<List<ProductModel>> getFridgeProducts(String fridgeId) {
    return _dataSource.getFridgeProducts(fridgeId);
  }

  Future<String> addProduct(ProductModel product) async {
    return await _dataSource.addProduct(product);
  }

  Future<void> updateProduct(ProductModel product) async {
    await _dataSource.updateProduct(product);
  }

  Future<void> deleteProduct(String productId) async {
    await _dataSource.deleteProduct(productId);
  }

  Future<ProductModel?> getProduct(String productId) async {
    return await _dataSource.getProduct(productId);
  }
}
