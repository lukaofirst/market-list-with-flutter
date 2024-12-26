// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:market_list_with_flutter/application/use_cases/products/interfaces/delete_all_products_use_case.dart';
import 'package:market_list_with_flutter/application/use_cases/products/interfaces/get_all_product_use_case.dart';
import 'package:market_list_with_flutter/domain/entities/product.dart';
import 'package:market_list_with_flutter/ioc/ioc.dart';
import 'package:market_list_with_flutter/ui/core/colors/marketlist_colors.dart';
import 'package:market_list_with_flutter/ui/screens/pre_checklist_screen.dart';
import 'package:market_list_with_flutter/ui/widgets/checklist/delete_button.dart';
import 'package:market_list_with_flutter/ui/widgets/shared/loading.dart';

import '../widgets/checklist/product_list_stored.dart';
import '../widgets/shared/alert_app_dialog.dart';
import '../widgets/shared/button_to_top.dart';
import '../widgets/shared/close_app_dialog.dart';

class ChecklistScreen extends StatefulWidget {
  static const routeName = 'checklist';

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final GetAllProductsUseCase _getAllProductUseCase =
      getIt<GetAllProductsUseCase>();
  final DeleteAllProductsUseCase _deleteAllProductsUseCase =
      getIt<DeleteAllProductsUseCase>();
  final ScrollController _scrollController = ScrollController();
  late Future<List<Product>> _futureGetStoredProducts;
  bool showBtn = false;

  @override
  void initState() {
    _futureGetStoredProducts = Future.delayed(
      const Duration(milliseconds: 300),
      () async {
        var products = await _getAllProductUseCase.execute();

        return products.where((element) => element.picked).toList();
      },
    ).then((value) {
      setState(() {
        _futureGetStoredProducts = Future.value(value);
      });
      return value;
    });

    _scrollController.addListener(() {
      var showOffset = 10.0;

      if (_scrollController.offset > showOffset) {
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

  Future<void> _deleteProducts() async {
    _deleteAllProductsUseCase.execute();

    if (mounted) {
      Navigator.of(context).pushReplacementNamed(PreChecklistScreen.routeName);
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
        body: FutureBuilder(
          future: _futureGetStoredProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return Column(
                children: [
                  DeleteButton(action: _confirmDeleteProducts),
                  ProductListStored(
                    items: snapshot.data!,
                    scrollController: _scrollController,
                  )
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
          scrollController: _scrollController,
        ),
      ),
    );
  }
}
