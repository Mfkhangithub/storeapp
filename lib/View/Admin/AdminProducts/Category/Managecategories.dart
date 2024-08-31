import 'package:flutter/material.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/View/Admin/AdminProducts/Category/Clothes/clotheseditpage.dart';
// import 'package:store_app/View/Admin/Firebasefirestore/electronicsstore.dart';
// import 'package:store_app/View/Admin/Firebasefirestore/glocerystore.dart';
import 'package:store_app/View/Admin/Firebasefirestore/shoesstore.dart';

class CategoryMangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Categories", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryVariant,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          buildCategoryItem(context, 'Clothes', 'assets/clothes.jpeg', ClothesProScreen()),
          buildCategoryItem(context, 'Shoes', 'assets/shoes.jpeg', FirestorePostShoesscreen()),
          // buildCategoryItem(context, 'Grocery', 'assets/foods.jpeg', FirestoreGloceryPostscreen()),
          // buildCategoryItem(context, 'Electronics', 'assets/electronics.jpeg', FirestoreElectronicsPostscreen()),
        ],
      ),
    );
  }

  Widget buildCategoryItem(BuildContext context, String title, String imagePath, Widget destinationScreen) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[350],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 140),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}