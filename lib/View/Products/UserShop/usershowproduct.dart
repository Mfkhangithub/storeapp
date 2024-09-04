import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Constant/categoriesclass.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Provider/Addtocard.dart';
import 'package:store_app/Provider/favoriteprovider.dart';
import 'package:store_app/View/Products/Carddata.dart';
import 'package:store_app/View/Products/favoritescreen.dart';

class ShowProductScreen extends StatelessWidget {
  final String shopId;

  const ShowProductScreen({Key? key, required this.shopId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text("Products", style: TextStyle(color: Colors.white)),
        centerTitle: true,
         iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryVariant,
             actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Consumer<CartState>(
                  builder: (context, cartState, child) {
                    return cartState.itemCount > 0
                        ? CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 10,
                            child: Text(
                              cartState.itemCount.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          )
                        : SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
           Stack(
             alignment: Alignment.center,
             children: [
               IconButton(
                 icon: Icon(Icons.favorite, color: Colors.white),
                 onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => FavoritesScreen()),
                   );
                 },
               ),
               Positioned(
                 right: 0,
                 top: 0,
                 child: Consumer<FavoritesProvider>(
                   builder: (context, favoritesProvider, child) {
                     return favoritesProvider.items.isNotEmpty
                         ? CircleAvatar(
                             backgroundColor: Colors.red,
                             radius: 10,
                             child: Text(
                               favoritesProvider.items.length.toString(),
                               style: TextStyle(fontSize: 12, color: Colors.white),
                             ),
                           )
                         : SizedBox.shrink();
                   },
                 ),
               ),
             ],
           ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('shops').doc(shopId).collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong!"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No products available"));
          }

          return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.50, // Adjust for the item height
                ),
                itemBuilder: (context, index) {
                  var doc = snapshot.data!.docs[index];
                  var data = doc.data() as Map<String, dynamic>;
                  String? imageUrl = data.containsKey('imageUrl') ? data['imageUrl'] : null;
      
         return GridItemWidget(
           item: GridItem(
             imageUrl: imageUrl.toString(),
             title: data['title'].toString(),
             itemName: data['description'].toString(),
             price: data['price'].toString(),
             discountedPrice: data['discount'].toString(),
             category: '',
           ),
         );
                    },
                  );
        },
      ),
    );
  }
}
