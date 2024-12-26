import 'package:market_list_with_flutter/application/use_cases/products/interfaces/delete_all_products_use_case.dart';
import 'package:market_list_with_flutter/infra/persistence/shared_preferences/products/interfaces/product_repository.dart';

class DeleteAllProductsUseCaseImpl implements DeleteAllProductsUseCase {
  late final ProductRepository _repository;

  DeleteAllProductsUseCaseImpl(ProductRepository productRepository) {
    _repository = productRepository;
  }

  @override
  void execute() {
    _repository.deleteAll();
  }
}
