// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:market_list_with_flutter/application/use_cases/products/interfaces/get_all_product_use_case.dart';
import 'package:market_list_with_flutter/ioc/ioc.dart';
import 'package:market_list_with_flutter/ui/screens/checklist_screen.dart';
import 'package:market_list_with_flutter/ui/screens/pre_checklist_screen.dart';
import 'package:market_list_with_flutter/ui/widgets/shared/loading.dart';

import '../../domain/entities/product.dart';
import '../widgets/shared/close_app_dialog.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _futureGetStoredProducts;
  late GetAllProductsUseCase _getAllProductUseCase;

  @override
  void initState() {
    _getAllProductUseCase = getIt<GetAllProductsUseCase>();
    _futureGetStoredProducts = _getAllProductUseCase.execute().then(
          (products) => products.where((element) => element.picked).toList(),
        );
    super.initState();
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
        body: FutureBuilder(
          future: _futureGetStoredProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData &&
                  snapshot.data!.any((product) => product.picked)) {
                return ChecklistScreen();
              } else {
                return PreChecklistScreen();
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
