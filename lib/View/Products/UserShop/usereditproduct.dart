import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Utils/utils.dart';
import 'package:store_app/View/Products/UserShop/usereditproductscreen.dart';

class UserEditProductScreen extends StatelessWidget {
  final String shopId;
  const UserEditProductScreen({Key? key, required this.shopId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products',
          style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryVariant,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('shops')
            .doc(shopId)
            .collection('products')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product['title']),
                subtitle: Text('Price: \$${product['price']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProductScreen(
                              shopId: shopId,
                              productId: product.id,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteProduct(product.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _deleteProduct(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('shops')
          .doc(shopId)
          .collection('products')
          .doc(productId)
          .delete();
      Utils().toasMessage('Product deleted successfully!');
    } catch (error) {
      Utils().toasMessage('Failed to delete product: $error');
    }
  }
}
