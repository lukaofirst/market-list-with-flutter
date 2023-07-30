import 'package:flutter/material.dart';
import 'package:market_list_with_flutter/screen/check_list_screen.dart';
import 'package:market_list_with_flutter/screen/save_list_screen.dart';

import 'screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.white,
      ),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        SaveListScreen.routeName: (context) => SaveListScreen(),
        CheckListScreen.routeName: (context) => CheckListScreen()
      },
    );
  }
}
