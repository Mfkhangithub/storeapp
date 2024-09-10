import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Constant/categoriesclass.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Constant/foother.dart';
import 'package:store_app/Functions/clothesfunctions.dart';
import 'package:store_app/Provider/Addtocard.dart';
import 'package:store_app/Provider/Alllinks.dart';
import 'package:store_app/Provider/favoriteprovider.dart';
import 'package:store_app/View/Dashboard/Drawer/mydrawer.dart';
import 'package:store_app/View/Dashboard/animatedscreen.dart';
import 'package:store_app/View/Products/Carddata.dart';
import 'package:store_app/View/Products/UserShop/allshopsview.dart';
import 'package:store_app/View/Products/UserShop/userdashboard.dart';
import 'package:store_app/View/Products/UserShop/usershowproduct.dart';
import 'package:store_app/View/Products/View%20Produtcs/clothesview.dart';
import 'package:store_app/View/Products/View%20Produtcs/shoesview.dart';
import 'package:store_app/View/Products/favoritescreen.dart';
import 'package:store_app/View/Videoscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  final FirebaseServiceClothes firebaseService = FirebaseServiceClothes(); // Create an instance of FirebaseService
  final fireStore = FirebaseFirestore.instance.collection("clothesdata").snapshots();
  final fireStoreShoes = FirebaseFirestore.instance.collection("shoesdata").snapshots();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
     String currentUserUid = _auth.currentUser!.uid;
        final provider = Provider.of<ProviderController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SHOP NOW",
          style: TextStyle(color: Colors.white),
        ),
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
      drawer: MyDrawer(),
body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 250, child: AnimatedScreen()),
      Divider(thickness: 6,),
     Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Shops", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
             GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AllShopsView(currentUserUid: currentUserUid,)));
              },
              child: Icon(Icons.shop)),
          ],
        ),
      ),
      StreamBuilder<QuerySnapshot>(
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

          return SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var shop = snapshot.data!.docs[index];
                var shopUserId = shop['userId'];

                return GestureDetector(
                  onTap: () {
                    if (shopUserId == currentUserUid) {
                       _showShopOptionsDialog(context, currentUserUid, shop.id);
                    } else {
                      // Navigate to show products screen if UID does not match
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowProductScreen(shopId: shop.id),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 220,
                    width: 250,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Stack(
                        children: [
                          // Full-screen image
                          shop['imageUrl'] != null
                              ? Image.network(
                                  shop['imageUrl'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : Icon(Icons.store, size: 80),
                          // Blur effect and text overlay at the bottom-right
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                child: Text(
                                  shop['marketName'].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                child: Text(
                                  shop['shopNumber'].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                child: Text(
                                  shop['shopName'].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      Gutter(),   
      Divider(thickness: 6,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Clothes Products", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
             GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ClothesProductView()));
              },
              child: Text("View All", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
          ],
        ),
      ),
      StreamBuilder<QuerySnapshot>(
        stream: fireStore,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text("Some Error");
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No data available"));
          }
          return SizedBox(
            height: 400, // Adjust the height to fit the content
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                var data = doc.data() as Map<String, dynamic>;
                String? imageUrl = data.containsKey('imageUrl') ? data['imageUrl'] : null;
        
                return Container(
                  width: 250,
                  child: GridItemWidget(
                    item: GridItem(
                      imageUrl: imageUrl.toString(),
                      title: data['title'].toString(),
                      itemName: data['description'].toString(),
                      price: data['price'].toString(),
                      discountedPrice: data['discount'].toString(),
                      category: '',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      Divider(thickness: 6,),
     Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Shoes Products", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
             GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ShoesProductView()));
              },
              child: Text("View All", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
          ],
        ),
      ),
         StreamBuilder<QuerySnapshot>(
        stream: fireStoreShoes,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) return Text("Some Error");
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No data available"));
          }
          return SizedBox(
            height: 400, // Adjust the height to fit the content
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                var data = doc.data() as Map<String, dynamic>;
                String? imageUrl = data.containsKey('imageUrl') ? data['imageUrl'] : null;
        
                return Container(
                  width: 250, // Adjust the width of each item
                  margin: EdgeInsets.only(right: 8.0),
                  child: GridItemWidget(
                    item: GridItem(
                      imageUrl: imageUrl.toString(),
                      title: data['title'].toString(),
                      itemName: data['description'].toString(),
                      price: data['price'].toString(),
                      discountedPrice: data['disprice'].toString(),
                      category: 'Clothes',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      Gutter(),
      Gutter(),
      Divider(thickness: 6,),
      Gutter(),
      ElevatedButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> VideoPickerScreen()));
      }, child: Text('Watch Video')),
      Gutter(),
      FooterWidget(provider: provider),
    ],
  ),
),
    );
    }
    void _showShopOptionsDialog(BuildContext context, String userId, String shopId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Choose an Option"),
        content: Text("Would you like to create a new product or view products?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDashboard(shopId: shopId,
                  userId: userId,),
                ),
              );
            },
            child: Text("User Dashboard"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowProductScreen(shopId: shopId),
                ),
              );
            },
            child: Text("Show Products"),
          ),
        ],
      ),
    );
  }
    }