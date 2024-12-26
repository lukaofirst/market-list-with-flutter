import 'package:flutter/material.dart';
import 'package:market_list_with_flutter/application/use_cases/product_item_stored_on_checklist/interfaces/load_checked_state_product_item_stored_on_checklist_use_case.dart';
import 'package:market_list_with_flutter/application/use_cases/product_item_stored_on_checklist/interfaces/save_checked_state_product_item_stored_on_checklist_use_case.dart';
import 'package:market_list_with_flutter/domain/entities/product.dart';
import 'package:market_list_with_flutter/ioc/ioc.dart';

class ProductItemStored extends StatefulWidget {
  final Product storedItem;

  const ProductItemStored({super.key, required this.storedItem});

  @override
  State<ProductItemStored> createState() => _ProductItemStoredState();
}

class _ProductItemStoredState extends State<ProductItemStored> {
  final LoadCheckedStateProductItemStoredOnChecklistUseCase
      _loadCheckedStateUseCase =
      getIt<LoadCheckedStateProductItemStoredOnChecklistUseCase>();
  final SaveCheckedStateProductItemStoredOnChecklistUseCase
      _saveCheckedStateUseCase =
      getIt<SaveCheckedStateProductItemStoredOnChecklistUseCase>();
  var isChecked = false;

  @override
  void initState() {
    super.initState();
    _loadCheckedState();
  }

  _loadCheckedState() async {
    var isCheckedUpdated =
        await _loadCheckedStateUseCase.execute(widget.storedItem.name);

    setState(() {
      isChecked = isCheckedUpdated;
    });
  }

  _saveCheckedState() {
    _saveCheckedStateUseCase.execute(widget.storedItem.name, isChecked);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });

        _saveCheckedState();
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isChecked ? Colors.green : Colors.black26,
          borderRadius: BorderRadius.circular(20),
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.storedItem.name,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  widget.storedItem.quantity.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
