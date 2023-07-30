import 'package:flutter/material.dart';
import 'package:market_list_with_flutter/models/product.dart';

class ProductItem extends StatefulWidget {
  final Product item;
  final Function saveItem;

  const ProductItem({super.key, required this.item, required this.saveItem});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem>
    with AutomaticKeepAliveClientMixin {
  var isChecked = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    setState(() {
      widget.item.quantity = 1;
    });
  }

  void _addQuantity() {
    setState(() {
      widget.item.quantity++;
    });
  }

  void _subtractQuantity() {
    setState(() {
      if (widget.item.quantity == 0) {
        widget.item.quantity = 0;
      } else {
        widget.item.quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var theme = Theme.of(context);

    return Container(
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
                widget.item.name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ),
            if (!isChecked)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _subtractQuantity,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(4),
                        backgroundColor: Colors.orange,
                        foregroundColor: theme.primaryColor,
                      ),
                      child: Icon(
                        Icons.remove,
                        semanticLabel:
                            'Subtracts 1 quantity to ${widget.item.name}',
                        size: 50,
                      ),
                    ),
                    Container(
                      width: 80,
                      alignment: Alignment.center,
                      child: Text(
                        widget.item.quantity.toString(),
                        style: TextStyle(
                          fontSize: 40,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _addQuantity,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(4),
                        backgroundColor: Colors.orange,
                        foregroundColor: theme.primaryColor,
                      ),
                      child: Icon(
                        Icons.add,
                        semanticLabel: 'Adds 1 quantity to ${widget.item.name}',
                        size: 50,
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  widget.saveItem(widget.item);

                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.black26,
                ),
                child: isChecked
                    ? Icon(
                        Icons.remove,
                        semanticLabel:
                            'Added ${widget.item.quantity} from product ${widget.item.name} to your list',
                        size: 50,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.add,
                        semanticLabel:
                            'Removed ${widget.item.quantity} from product ${widget.item.name} to your list',
                        size: 50,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
