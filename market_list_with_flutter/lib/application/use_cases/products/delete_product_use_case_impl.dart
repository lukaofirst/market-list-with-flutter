import 'package:market_list_with_flutter/application/use_cases/products/interfaces/delete_product_use_case.dart';
import 'package:market_list_with_flutter/infra/persistence/shared_preferences/products/interfaces/product_repository.dart';

class DeleteProductUseCaseImpl implements DeleteProductUseCase {
  late final ProductRepository _repository;

  DeleteProductUseCaseImpl(ProductRepository productRepository) {
    _repository = productRepository;
  }

  @override
  void execute(int id) {
    var product = _repository.getById(id);

    if (product == null) {
      throw Exception('Product not found');
    }

    _repository.delete(id);
  }
}
