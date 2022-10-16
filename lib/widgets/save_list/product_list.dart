// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

import '../../models/product.dart';
import 'product_item.dart';

class ProductList extends StatelessWidget {
  final List<Product> items;
  final ScrollController scrollController;
  Function saveItem;

  ProductList({
    required this.items,
    required this.saveItem,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (_, idx) => ProductItem(
          key: Key(items[idx].id.toString()),
          item: items[idx],
          saveItem: saveItem,
        ),
        itemCount: items.length,
      ),
    );
  }
}
