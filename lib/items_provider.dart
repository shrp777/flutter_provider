import 'package:flutter/material.dart';

import 'item.dart';

class ItemsProvider extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => _items;

  add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  remove(Item item) {
    if (_items.contains(item)) {
      _items.remove(item);
      notifyListeners();
    } else {
      throw Exception("Item not found");
    }
  }

  clear() {
    _items.clear();
    notifyListeners();
  }
}
