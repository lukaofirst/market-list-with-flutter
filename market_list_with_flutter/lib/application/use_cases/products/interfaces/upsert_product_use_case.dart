import 'package:market_list_with_flutter/domain/entities/product.dart';

abstract class UpsertProductUseCase {
  void execute(Product product);
}
