import 'package:market_list_with_flutter/application/use_cases/products/interfaces/delete_all_products_use_case.dart';
import 'package:market_list_with_flutter/infra/persistence/interfaces/product_repository.dart';

class DeleteAllProductsUseCaseImpl implements DeleteAllProductsUseCase {
  late final ProductRepository _productRepository;

  DeleteAllProductsUseCaseImpl(ProductRepository productRepository) {
    _productRepository = productRepository;
  }

  @override
  void execute() {
    _productRepository.deleteAll();
  }
}
