import 'package:market_list_with_flutter/application/use_cases/products/interfaces/upsert_product_use_case.dart';
import 'package:market_list_with_flutter/domain/entities/product.dart';
import 'package:market_list_with_flutter/infra/persistence/shared_preferences/products/interfaces/product_repository.dart';

class UpsertProductUseCaseImpl implements UpsertProductUseCase {
  late final ProductRepository _repository;

  UpsertProductUseCaseImpl(ProductRepository productRepository) {
    _repository = productRepository;
  }

  @override
  void execute(Product product) {
    _repository.upsert(product);
  }
}
