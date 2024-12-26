import 'package:market_list_with_flutter/application/use_cases/products/interfaces/get_all_product_use_case.dart';
import 'package:market_list_with_flutter/domain/entities/product.dart';
import 'package:market_list_with_flutter/infra/persistence/interfaces/product_repository.dart';

class GetAllProductsUseCaseImpl implements GetAllProductsUseCase {
  late final ProductRepository _productRepository;

  GetAllProductsUseCaseImpl(ProductRepository productRepository) {
    _productRepository = productRepository;
  }

  @override
  Future<List<Product>> execute() async {
    var products = await _productRepository.getAll();

    return products;
  }
}
