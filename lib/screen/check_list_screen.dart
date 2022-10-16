// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:market_list_flutter/models/product.dart';
import 'package:market_list_flutter/screen/save_list_screen.dart';
import 'package:market_list_flutter/widgets/check_list/delete_button.dart';
import 'package:market_list_flutter/widgets/shared/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/check_list/product_list_stored.dart';
import '../widgets/shared/alert_app_dialog.dart';
import '../widgets/shared/button_to_top.dart';
import '../widgets/shared/close_app_dialog.dart';

class CheckListScreen extends StatefulWidget {
  static const routeName = 'check-list';

  @override
  State<CheckListScreen> createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  late Future<List<Product>> _futureGetStoredProducts;
  ScrollController scrollController = ScrollController();
  bool showBtn = false;

  @override
  void initState() {
    _futureGetStoredProducts = Future.delayed(
      const Duration(seconds: 3),
      () => _getStoredProducts(),
    );

    scrollController.addListener(() {
      var showOffset = 10.0;

      if (scrollController.offset > showOffset) {
        setState(() {
          showBtn = true;
        });
      } else {
        setState(() {
          showBtn = false;
        });
      }
    });

    super.initState();
  }

  Future<List<Product>> _getStoredProducts() async {
    var sharedPreferences = await SharedPreferences.getInstance();

    var storedProductsString = sharedPreferences.getString('products');

    if (storedProductsString != null && storedProductsString.isNotEmpty) {
      var formattedStoredProducts =
          (json.decode(storedProductsString) as List<dynamic>)
              .map((e) => Product.fromJson(e))
              .toList();

      return formattedStoredProducts;
    }

    return [];
  }

  Future<void> _deleteProducts() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.remove('products');

    if (mounted) {
      Navigator.of(context).pushReplacementNamed(SaveListScreen.routeName);
    }
  }

  Future<void> _confirmDeleteProducts() async {
    return showDialog(
      context: context,
      builder: (_) => AlertAppDialog(
        message: 'Deletar lista atual?',
        action: _deleteProducts,
      ),
    );
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
        body: FutureBuilder(
          future: _futureGetStoredProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return Column(
                children: [
                  DeleteButton(action: _confirmDeleteProducts),
                  ProductListStored(items: snapshot.data!)
                ],
              );
            } else {
              return const Loading(
                message: 'Carregando informações...',
              );
            }
          },
        ),
        floatingActionButton: ButtonToTop(
          showBtn: showBtn,
          scrollController: scrollController,
        ),
      ),
    );
  }
}
