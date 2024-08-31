import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store_app/Constant/categoriesclass.dart';
import 'package:store_app/View/Products/itemdetailscreen.dart';

class ClothesSearchDelegate extends SearchDelegate {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> allClothes;

  ClothesSearchDelegate(this.allClothes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredClothes = allClothes.where((doc) {
      final data = doc.data();
      final title = data['title'].toString().toLowerCase();
      return title.contains(query.toLowerCase());
    }).toList();

    return _buildSearchResults(filteredClothes);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredClothes = allClothes.where((doc) {
      final data = doc.data();
      final title = data['title'].toString().toLowerCase();
      return title.contains(query.toLowerCase());
    }).toList();

    return _buildSearchResults(filteredClothes);
  }

 Widget _buildSearchResults(List<QueryDocumentSnapshot<Map<String, dynamic>>> results) {
  return ListView.builder(
    itemCount: results.length,
    itemBuilder: (context, index) {
      var doc = results[index];
      var data = doc.data();
      
      // Creating a GridItem object with the necessary data
      GridItem item = GridItem(
        imageUrl: data['imageUrl'] ?? '', // Ensure to handle null cases
        title: data['title'] ?? 'No Title',
        itemName: data['description'] ?? 'No Description',
        price: data['price'] ?? '0',
        discountedPrice: data['disprice'] ?? '0',
        category: '', // You can set this if you have category data
      );
      
      return ListTile(
        title: Text(item.title),
        onTap: () {
          // Navigate to the item detail screen with the relevant data
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailScreen(item: item),
            ),
          );
        },
      );
    },
  );
}

}
