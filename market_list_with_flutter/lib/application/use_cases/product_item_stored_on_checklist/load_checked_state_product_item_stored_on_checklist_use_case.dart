import 'package:market_list_with_flutter/application/use_cases/product_item_stored_on_checklist/interfaces/load_checked_state_product_item_stored_on_checklist_use_case.dart';
import 'package:market_list_with_flutter/infra/persistence/shared_preferences/product_on_checklist_picked_state/interfaces/product_item_stored_on_checklist_repository.dart';
import 'package:market_list_with_flutter/ioc/ioc.dart';

class LoadCheckedStateProductItemStoredOnChecklistUseCaseImpl
    implements LoadCheckedStateProductItemStoredOnChecklistUseCase {
  final ProductItemStoredOnChecklistRepository _repository =
      getIt<ProductItemStoredOnChecklistRepository>();

  @override
  Future<bool> execute(String storedProductName) async {
    return await _repository.loadCheckedState(storedProductName);
  }
}
