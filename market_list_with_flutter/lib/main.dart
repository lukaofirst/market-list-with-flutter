import 'package:flutter/material.dart';
import 'package:market_list_with_flutter/ioc/ioc.dart';
import 'package:market_list_with_flutter/ui/core/theme/theme_data.dart';
import 'package:market_list_with_flutter/ui/screens/checklist_screen.dart';
import 'package:market_list_with_flutter/ui/screens/pre_checklist_screen.dart';

import 'ui/screens/home_screen.dart';

void main() {
  IoC().addRepositories().addUseCases();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: getThemeData(),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        PreChecklistScreen.routeName: (context) => PreChecklistScreen(),
        ChecklistScreen.routeName: (context) => ChecklistScreen()
      },
    );
  }
}
