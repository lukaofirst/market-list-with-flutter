import 'package:market_list_with_flutter/infra/persistence/shared_preferences/product_on_checklist_picked_state/interfaces/product_item_stored_on_checklist_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductItemStoredOnChecklistRepositoryImpl
    implements ProductItemStoredOnChecklistRepository {
  @override
  Future<bool> loadCheckedState(String storedProductName) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isChecked_$storedProductName') ?? false;
  }

  @override
  Future<void> saveCheckedState(
    String storedProductName,
    bool isChecked,
  ) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isChecked_$storedProductName', isChecked);
  }
}
