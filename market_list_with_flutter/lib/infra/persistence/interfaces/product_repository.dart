import 'package:market_list_with_flutter/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAll();
  Product? getById(int id);
  Future<void> upsert(Product product);
  Future<void> delete(int id);
  void deleteAll();
}
