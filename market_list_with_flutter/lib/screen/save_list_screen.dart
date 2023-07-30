// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:market_list_with_flutter/mocked_data.dart';
import 'package:market_list_with_flutter/models/product.dart';
import 'package:market_list_with_flutter/widgets/save_list/product_list.dart';
import 'package:market_list_with_flutter/widgets/shared/close_app_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/save_list/save_button.dart';
import '../widgets/shared/button_to_top.dart';

class SaveListScreen extends StatefulWidget {
  static const routeName = 'save-list';

  @override
  State<SaveListScreen> createState() => _SaveListScreenState();
}

class _SaveListScreenState extends State<SaveListScreen> {
  final List<Product> _productsToBeSaved = [];
  final ScrollController _scrollController = ScrollController();
  List<Product> _initialProducts = [];
  bool _showBtn = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      var showOffset = 10.0;

      if (_scrollController.offset > showOffset) {
        setState(() {
          _showBtn = true;
        });
      } else {
        setState(() {
          _showBtn = false;
        });
      }
    });

    super.initState();

    setState(() {
      _initialProducts = mockedItems;
    });
  }

  void _saveItem(Product item) {
    var productExist =
        _productsToBeSaved.any((product) => product.id == item.id);

    if (productExist) {
      _productsToBeSaved.removeWhere((product) => product.id == item.id);
    } else {
      _productsToBeSaved.add(item);
    }
  }

  void _saveProducts() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    _productsToBeSaved.sort((a, b) => a.id.compareTo(b.id));

    String encodedProducts = json.encode(_productsToBeSaved);

    await sharedPreferences.setString('products', encodedProducts);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (ctx) => CloseAppDialog(),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Lista de Compras'),
        ),
        body: Column(
          children: [
            SaveButton(action: _saveProducts),
            ProductList(
              items: _initialProducts,
              saveItem: _saveItem,
              scrollController: _scrollController,
            ),
          ],
        ),
        floatingActionButton: ButtonToTop(
          showBtn: _showBtn,
          scrollController: _scrollController,
        ),
      ),
    );
  }
}
