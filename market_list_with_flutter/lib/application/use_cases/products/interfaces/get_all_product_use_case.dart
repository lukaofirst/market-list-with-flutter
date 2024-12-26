import 'package:market_list_with_flutter/domain/entities/product.dart';

abstract class GetAllProductsUseCase {
  Future<List<Product>> execute();
}
