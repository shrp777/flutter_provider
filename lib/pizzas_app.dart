import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pizzas_prvd/pizza.dart';
import 'package:pizzas_prvd/items_provider.dart';

class PizzasApp extends StatelessWidget {
  const PizzasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Pizzas Provider"),
        ),
        body: Center(
          child: Consumer<ItemsProvider>(builder: (
            context,
            ItemsProvider itemsProvider,
            child,
          ) {
            return ListView.builder(
              itemCount: itemsProvider.items.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(
                  itemsProvider.items[index].name,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () =>
                      itemsProvider.remove(itemsProvider.items[index]),
                ),
              ),
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final List<String> pizzasName = [
              "Margherita",
              "Quattro Stagioni",
              "Regina",
              "Romana",
              "Marinara",
              "Diavola",
              "Capricciosa",
              "Ortolana",
              "Frutti di mare"
            ];

            final int randomInt = Random().nextInt(pizzasName.length);

            final String randomPizzaName = pizzasName[randomInt];

            final Pizza item = Pizza(name: randomPizzaName);
            Provider.of<ItemsProvider>(context, listen: false).add(item);
          },
          child: const Icon(Icons.add),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
            onPressed: () =>
                Provider.of<ItemsProvider>(context, listen: false).clear(),
            child: const Icon(Icons.delete_forever),
          ),
        ),
      ),
    );
  }
}
