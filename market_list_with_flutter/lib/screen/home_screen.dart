// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:market_list_with_flutter/screen/save_list_screen.dart';
import 'package:market_list_with_flutter/widgets/shared/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';
import '../widgets/shared/close_app_dialog.dart';
import 'check_list_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _futureGetStoredProducts;

  @override
  void initState() {
    _futureGetStoredProducts = Future.delayed(
      const Duration(seconds: 3),
      () => _getStoredProducts(),
    );

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

  Future<List<Product>> getStoredProducts() async {
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

  void navigateToSaveListScreen(BuildContext context) {
    Navigator.of(context).pushNamed(SaveListScreen.routeName);
  }

  void navigateToCheckListScreen(BuildContext context) {
    Navigator.of(context).pushNamed(CheckListScreen.routeName);
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
        body: FutureBuilder(
          future: _futureGetStoredProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.isNotEmpty) {
                return CheckListScreen();
              } else {
                return SaveListScreen();
              }
            } else {
              return const Loading(
                message: 'Iniciando aplicativo...',
              );
            }
          },
        ),
      ),
    );
  }
}
