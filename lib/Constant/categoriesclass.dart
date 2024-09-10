import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Constant/orderbutton.dart';
import 'package:store_app/Provider/Addtocard.dart';
import 'package:store_app/Provider/favoriteprovider.dart';
import 'package:store_app/View/Products/itemdetailscreen.dart';

class GridItem {
  final String imageUrl;
  final String title;
  final String itemName;
  final String price;
  final String discountedPrice;

  GridItem({
    required this.imageUrl,
    required this.title,
    required this.itemName,
    required this.price,
    required this.discountedPrice,
    required String category,
  });
}

class GridItemWidget extends StatefulWidget {
  final GridItem item;

  GridItemWidget({required this.item});

  @override
  State<GridItemWidget> createState() => _GridItemWidgetState();
}

class _GridItemWidgetState extends State<GridItemWidget> {
   bool _showOptions = false;

  void _toggleOptions() {
    setState(() {
      _showOptions = !_showOptions;
    });
  }
  @override
  Widget build(BuildContext context) {
    const defaultImageUrl = 'https://via.placeholder.com/150'; // Default image URL
    final imageUrl = widget.item.imageUrl.isNotEmpty ? widget.item.imageUrl : defaultImageUrl;
    return GestureDetector(
      onTap: _toggleOptions,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container for the image
          Container(
            height: 250,
            width: double.infinity,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: Stack(
                children: [
                  Image.network(
                    widget.item.imageUrl,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Blur effect and text overlay
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: Text(
                        widget.item.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
              top: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryVariant,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    // Handle order button click
                    Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailScreen(item: widget.item),
                ),
              );
                    print('Order button pressed');
                  },
                  icon: Icon(Icons.shopping_cart_outlined),
                  iconSize: 30,
                  color: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  tooltip: 'Order Now',
                  splashRadius: 25,
                  splashColor: AppColors.primaryVariant,
                  highlightColor: Colors.transparent,
                ),
              ),
            ),
                  // Animated container with options
                  Positioned(
                    bottom: _showOptions ? 0 : -80,
                    left: 0,
                    right: 0,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: _showOptions ? 80 : 0,
                      color: Colors.black.withOpacity(0.3),
                      child: _showOptions ? _buildOptions() : SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Text widgets for title, description, price, and discounted price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'fadiishop.com',
                  style: TextStyle(fontSize: 15,),
                ),
                Text(widget.item.itemName,
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                Text(
                  'Rs: ${widget.item.price}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rs: ${widget.item.discountedPrice}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

    Widget _buildOptions() {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    return Container(
       height: MediaQuery.of(context).size.width * 0.12, // Adjust height based on screen width
       width: double.infinity,
      color: Colors.black.withOpacity(0.6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.add_shopping_cart,color: Colors.white, size: MediaQuery.of(context).size.width * 0.06),
            onPressed: () {
                Provider.of<CartState>(context, listen: false).addItem(widget.item);
              // Add to cart logic here
            },
          ),
          IconButton(
            icon: Icon(Icons.remove_red_eye, color: Colors.white, size: MediaQuery.of(context).size.width * 0.06),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailScreen(item: widget.item),
                ),
              );
              // See item logic here
            },
          ),  
         IconButton(
            icon: Icon(
              Icons.favorite,
              size: MediaQuery.of(context).size.width * 0.06,
              color: favoritesProvider.isFavorite(widget.item) ? Colors.red : Colors.white,
            ),
            onPressed: () {
              if (favoritesProvider.isFavorite(widget.item)) {
                favoritesProvider.removeFavorite(widget.item);
              } else {
                favoritesProvider.addFavorite(widget.item);
              }
            },
          ),
        ],
      ),
    );
  }
}
