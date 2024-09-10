import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/View/Admin/AdminProducts/Users/shopdetails.dart';

class ShopsListScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryVariant,
        title: Text("Shops", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('shops').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong!"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No shops available"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var shop = snapshot.data!.docs[index];

              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: shop['imageUrl'] != null
                      ? Image.network(
                          shop['imageUrl'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.store, size: 80),
                  title: Text(shop['marketName'] ?? 'No Market Name'),
                  subtitle: Text(shop['shopName'] ?? 'No Shop Name'),
                  trailing: Text(shop['shopNumber'] ?? 'No Shop Number'),
                  onTap: () {
                    _showShopOptionsDialog(context, shop.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Function to show dialog with Delete and Update options
  void _showShopOptionsDialog(BuildContext context, String shopId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose an option"),
          content: Text("What would you like to do with this shop?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _deleteShop(context, shopId); // Call delete function
              },
              child: Text("Delete Shop", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _navigateToUpdateShop(context, shopId); // Navigate to update screen
              },
              child: Text("Update Shop"),
            ),
          ],
        );
      },
    );
  }

  // Function to delete the shop from Firestore
  void _deleteShop(BuildContext context, String shopId) async {
    try {
      await _firestore.collection('shops').doc(shopId).delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Shop deleted successfully!'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete shop: $e'),
      ));
    }
  }

  // Function to navigate to the update shop screen (implement separately)
  void _navigateToUpdateShop(BuildContext context, String shopId) {
    // Implement navigation to your update screen here
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateShopScreen(shopId: shopId), // Example: Navigate to an update screen
      ),
    );
  }
}