import 'package:get_it/get_it.dart';
import 'package:market_list_with_flutter/application/use_cases/products/upsert_product_use_case_impl.dart';
import 'package:market_list_with_flutter/application/use_cases/products/delete_product_use_case_impl.dart';
import 'package:market_list_with_flutter/application/use_cases/products/get_all_products_use_case_impl.dart';
import 'package:market_list_with_flutter/application/use_cases/products/delete_all_products_use_case_impl.dart';
import 'package:market_list_with_flutter/application/use_cases/products/interfaces/upsert_product_use_case.dart';
import 'package:market_list_with_flutter/application/use_cases/products/interfaces/delete_product_use_case.dart';
import 'package:market_list_with_flutter/application/use_cases/products/interfaces/get_all_product_use_case.dart';
import 'package:market_list_with_flutter/application/use_cases/products/interfaces/delete_all_products_use_case.dart';
import 'package:market_list_with_flutter/infra/persistence/interfaces/product_repository.dart';
import 'package:market_list_with_flutter/infra/persistence/shared_preferences/product_repository_impl.dart';

final getIt = GetIt.instance;

class IoC {
  IoC addRepositories() {
    getIt.registerSingleton<ProductRepository>(ProductRepositoryImpl());

    return this;
  }

  IoC addUseCases() {
    getIt.registerSingleton<GetAllProductsUseCase>(
        GetAllProductsUseCaseImpl(getIt.get<ProductRepository>()));

    getIt.registerSingleton<UpsertProductUseCase>(
        UpsertProductUseCaseImpl(getIt.get<ProductRepository>()));

    getIt.registerSingleton<DeleteProductUseCase>(
        DeleteProductUseCaseImpl(getIt.get<ProductRepository>()));

    getIt.registerSingleton<DeleteAllProductsUseCase>(
        DeleteAllProductsUseCaseImpl(getIt.get<ProductRepository>()));

    return this;
  }
}
