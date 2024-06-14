import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pizzas_prvd/items_provider.dart';
import 'package:pizzas_prvd/pizzas_app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ItemsProvider>(
        create: (_) => ItemsProvider(),
      ),
    ],
    child: const PizzasApp(),
  ));
}
