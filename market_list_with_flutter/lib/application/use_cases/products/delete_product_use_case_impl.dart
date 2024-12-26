import 'package:market_list_with_flutter/application/use_cases/products/interfaces/delete_product_use_case.dart';
import 'package:market_list_with_flutter/infra/persistence/interfaces/product_repository.dart';

class DeleteProductUseCaseImpl implements DeleteProductUseCase {
  late final ProductRepository _productRepository;

  DeleteProductUseCaseImpl(ProductRepository productRepository) {
    _productRepository = productRepository;
  }

  @override
  void execute(int id) {
    var product = _productRepository.getById(id);

    if (product == null) {
      throw Exception('Product not found');
    }

    _productRepository.delete(id);
  }
}
