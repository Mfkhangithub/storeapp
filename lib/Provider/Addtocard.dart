import 'package:flutter/material.dart';
import 'package:store_app/Constant/categoriesclass.dart';

class CartState extends ChangeNotifier {
  List<GridItem> _items = [];

  List<GridItem> get items => _items;

  int get itemCount => _items.length;

  void addItem(GridItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(GridItem item) {
    _items.remove(item);
    notifyListeners();
  }
}