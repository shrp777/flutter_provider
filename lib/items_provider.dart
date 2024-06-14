import 'package:flutter/material.dart';

import 'package:pizzas_prvd/pizza.dart';

class ItemsProvider extends ChangeNotifier {
  final List<Pizza> _items = [];

  List<Pizza> get items => List.unmodifiable(_items);
  //in order to send notifications to consumers
  //_items must not be modifiable from the outside

  void add(Pizza item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(Pizza item) {
    if (_items.contains(item)) {
      _items.remove(item);
      notifyListeners();
    } else {
      throw Exception("Item not found");
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
