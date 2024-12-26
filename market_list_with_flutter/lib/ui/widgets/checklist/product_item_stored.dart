import 'package:flutter/material.dart';
import 'package:market_list_with_flutter/domain/entities/product.dart';

class ProductItemStored extends StatefulWidget {
  final Product storedItem;

  const ProductItemStored({super.key, required this.storedItem});

  @override
  State<ProductItemStored> createState() => _ProductItemStoredState();
}

class _ProductItemStoredState extends State<ProductItemStored>
    with AutomaticKeepAliveClientMixin {
  var isChecked = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var theme = Theme.of(context);

    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
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
