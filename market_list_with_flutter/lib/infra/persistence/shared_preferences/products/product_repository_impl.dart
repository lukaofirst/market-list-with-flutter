import 'dart:convert';

import 'package:market_list_with_flutter/domain/entities/product.dart';
import 'package:market_list_with_flutter/infra/persistence/shared_preferences/products/interfaces/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepositoryImpl implements ProductRepository {
  final String _productsKey = 'products';
  final List<Product> _products = [];

  Future<SharedPreferences> _initSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> _saveChangesAsync() async {
    var sharedPreferences = await _initSharedPreferences();

    _products.sort((a, b) => a.id.compareTo(b.id));

    var productsAsJsonString =
        json.encode(_products.map((e) => e.toJson()).toList());

    await sharedPreferences.setString(_productsKey, productsAsJsonString);
  }

  @override
  Future<List<Product>> getAll() async {
    var sharedPreferences = await _initSharedPreferences();

    _products.sort((a, b) => a.id.compareTo(b.id));

    var productsAsJsonString = sharedPreferences.getString(_productsKey);

    if (productsAsJsonString != null) {
      var formattedStoredProducts =
          (json.decode(productsAsJsonString) as List<dynamic>)
              .map((e) => Product.fromJson(e))
              .toList();

      return formattedStoredProducts;
    }

    return [];
  }

  @override
  Product? getById(int id) {
    var index = _products.indexWhere((element) => element.id == id);
    return index != -1 ? _products[index] : null;
  }

  @override
  Future<void> upsert(Product product) async {
    product.wasPicked();

    var existingProduct = getById(product.id);

    if (existingProduct != null) {
      var index = _products.indexOf(existingProduct);
      _products[index] = product;
    } else {
      _products.add(product);
    }

    await _saveChangesAsync();
  }

  @override
  Future<void> delete(int id) async {
    _products.removeWhere((element) => element.id == id);
    await _saveChangesAsync();
  }

  @override
  Future<void> deleteAll() async {
    var sharedPreferences = await _initSharedPreferences();

    await sharedPreferences.clear();
  }
}
