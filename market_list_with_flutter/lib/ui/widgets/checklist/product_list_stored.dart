// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:market_list_with_flutter/ui/widgets/checklist/product_item_stored.dart';

import '../../../domain/entities/product.dart';

class ProductListStored extends StatelessWidget {
  final List<Product> items;
  final ScrollController scrollController;

  const ProductListStored({
    required this.items,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (_, idx) => ProductItemStored(storedItem: items[idx]),
        itemCount: items.length,
      ),
    );
  }
}
