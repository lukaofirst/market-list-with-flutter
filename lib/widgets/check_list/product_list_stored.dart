// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:market_list_flutter/widgets/check_list/product_item_stored.dart';

import '../../models/product.dart';

class ProductListStored extends StatelessWidget {
  final List<Product> items;

  const ProductListStored({required this.items});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (_, idx) => ProductItemStored(storedItem: items[idx]),
        itemCount: items.length,
      ),
    );
  }
}
