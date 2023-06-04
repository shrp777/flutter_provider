import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/items_provider.dart';

import 'item.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => ItemsProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Provider demo"),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
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
              ElevatedButton(
                onPressed: () =>
                    Provider.of<ItemsProvider>(context, listen: false).clear(),
                child: const Icon(Icons.delete_forever),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              final Item item = Item(name: "demo");
              Provider.of<ItemsProvider>(context, listen: false).add(item);
            },
            child: const Icon(Icons.add)),
      ),
    );
  }
}
