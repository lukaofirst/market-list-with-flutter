import 'package:market_list_with_flutter/application/use_cases/products/interfaces/upsert_product_use_case.dart';
import 'package:market_list_with_flutter/domain/entities/product.dart';
import 'package:market_list_with_flutter/infra/persistence/interfaces/product_repository.dart';

class UpsertProductUseCaseImpl implements UpsertProductUseCase {
  late final ProductRepository _productRepository;

  UpsertProductUseCaseImpl(ProductRepository productRepository) {
    _productRepository = productRepository;
  }

  @override
  void execute(Product product) {
    _productRepository.upsert(product);
  }
}
