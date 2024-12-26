// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:market_list_with_flutter/mocked_data.dart';
import 'package:market_list_with_flutter/domain/entities/product.dart';
import 'package:market_list_with_flutter/ui/core/colors/marketlist_colors.dart';
import 'package:market_list_with_flutter/ui/widgets/pre_checklist/product_list.dart';
import 'package:market_list_with_flutter/ui/widgets/shared/close_app_dialog.dart';

import '../widgets/pre_checklist/save_button.dart';
import '../widgets/shared/button_to_top.dart';

class PreChecklistScreen extends StatefulWidget {
  static const routeName = 'pre-checklist';

  @override
  State<PreChecklistScreen> createState() => _PreChecklistScreenState();
}

class _PreChecklistScreenState extends State<PreChecklistScreen> {
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (ctx) => CloseAppDialog(),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) => _onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Lista de Compras',
            style: TextStyle(
              color: MarketListColors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            SaveButton(),
            ProductList(
              items: _initialProducts,
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
