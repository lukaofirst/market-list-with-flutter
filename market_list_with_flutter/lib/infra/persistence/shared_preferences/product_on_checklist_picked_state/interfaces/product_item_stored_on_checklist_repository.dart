abstract class ProductItemStoredOnChecklistRepository {
  Future<bool> loadCheckedState(String storedProductName);
  void saveCheckedState(String storedProductName, bool isChecked);
}
