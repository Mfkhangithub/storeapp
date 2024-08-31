import 'package:flutter/material.dart';
import 'package:store_app/Constant/categoriesclass.dart';

class FavoritesProvider with ChangeNotifier {
  // A set to keep track of favorite item IDs

   List<GridItem> _items = [];

  List<GridItem> get items => _items; 


  void addFavorite(GridItem item) {
    _items.add(item); // Assuming itemName is unique
    notifyListeners();
  }

  void removeFavorite(GridItem item) {
    _items.remove(item);
    notifyListeners();
  }

  bool isFavorite(GridItem item) {
    return _items.contains(item.itemName);
  }
}
