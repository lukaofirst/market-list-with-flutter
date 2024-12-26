import 'package:market_list_with_flutter/application/use_cases/products/interfaces/get_all_product_use_case.dart';
import 'package:market_list_with_flutter/domain/entities/product.dart';
import 'package:market_list_with_flutter/infra/persistence/shared_preferences/products/interfaces/product_repository.dart';

class GetAllProductsUseCaseImpl implements GetAllProductsUseCase {
  late final ProductRepository _repository;

  GetAllProductsUseCaseImpl(ProductRepository productRepository) {
    _repository = productRepository;
  }

  @override
  Future<List<Product>> execute() async {
    var products = await _repository.getAll();

    return products;
  }
}
