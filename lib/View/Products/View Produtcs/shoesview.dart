import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Constant/categoriesclass.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Constant/searchdelagates.dart';
import 'package:store_app/Provider/Addtocard.dart';
import 'package:store_app/Provider/favoriteprovider.dart';
import 'package:store_app/View/Products/Carddata.dart';
import 'package:store_app/View/Products/favoritescreen.dart';

class ShoesProductView extends StatefulWidget {
  @override
  State<ShoesProductView> createState() => _ClothesProductViewState();
}

class _ClothesProductViewState extends State<ShoesProductView> {
  final fireStore = FirebaseFirestore.instance.collection("shoesdata").snapshots();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> allClothes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shoes Products",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryVariant,
             actions: [
               IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: () async {
            final result = await showSearch(
              context: context,
              delegate: ClothesSearchDelegate(allClothes),
            );
            // Handle search result if needed
          },
        ),
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
              stream: fireStore,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) return Text("Some Error");
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No data available"));
                }
                   allClothes = snapshot.data!.docs.map((doc) => doc as QueryDocumentSnapshot<Map<String, dynamic>>).toList();
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

                
      //           ListView.builder(
      //             scrollDirection: Axis.vertical,
      //             itemCount: snapshot.data!.docs.length,
      //             itemBuilder: (context, index) {
      //  var doc = snapshot.data!.docs[index];
      //  var data = doc.data() as Map<String, dynamic>;
      //  String? imageUrl = data.containsKey('imageUrl') ? data['imageUrl'] : null;
           
       return Container(
         width: 200, // Adjust the width of each item
         margin: EdgeInsets.only(right: 8.0),
         child: GridItemWidget(
           item: GridItem(
             imageUrl: imageUrl.toString(),
             title: data['title'].toString(),
             itemName: data['description'].toString(),
             price: data['price'].toString(),
             discountedPrice: data['disprice'].toString(),
             category: '',
           ),
         ),
       );
                  },
                );
              },
            ),
    );
  }
}
