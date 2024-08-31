import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:provider/provider.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: _toggleOptions,
          child: Stack(
            children:[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2), // Shadow color
                            blurRadius: 8, // Softness of the shadow
                            offset: Offset(0, 4), // Offset of the shadow
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.grey[200]!], // Gradient background
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3), // Border color
                          width: 1, // Border width
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1), // Same radius for the image to match the container
                        child: Image.network(
                          imageUrl,
                          height: constraints.maxHeight * 0.4, // Use 40% of the card's height
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                     Gutter(),
                     Text(
                       widget.item.title,
                       style: TextStyle(fontSize: constraints.maxWidth * 0.08,),
                     ),
                     Gutter(),
                     Text('fadiishop', style: TextStyle(fontSize: 11),),
                     Text(
                       widget.item.itemName,
                       style: TextStyle(fontSize: constraints.maxWidth * 0.07),
                     ),
                     Text(
                       'Rs: ${widget.item.price}',
                       style: TextStyle(fontSize: constraints.maxWidth * 0.08, fontWeight: FontWeight.bold),
                     ),
                     SizedBox(width: 8),
                     Text(
                      'Rs: ${widget.item.discountedPrice} %',
                       style: TextStyle(
                         fontSize: constraints.maxWidth * 0.07,
                         color: Colors.red,
                         decoration: TextDecoration.lineThrough,
                       ),
                     ),
                              ],),
              ),
             Positioned(
                  bottom: _showOptions ? 0 : -80, // Adjusted to avoid overflow
                  left: 0,
                  right: 0,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: _showOptions ? 80 : 0,
                    color: Colors.green.withOpacity(0.9),
                    child: _showOptions ? _buildOptions() : SizedBox.shrink(),
                  ),
                ),
                 
            ]  ),
        );
      },
    );
  }

    Widget _buildOptions() {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    return Container(
       height: MediaQuery.of(context).size.width * 0.12, // Adjust height based on screen width
       width: double.infinity,
      color: Colors.white.withOpacity(0.9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.add_shopping_cart,color: Colors.black, size: MediaQuery.of(context).size.width * 0.06),
            onPressed: () {
                Provider.of<CartState>(context, listen: false).addItem(widget.item);
              // Add to cart logic here
            },
          ),
          IconButton(
            icon: Icon(Icons.remove_red_eye, color: Colors.black, size: MediaQuery.of(context).size.width * 0.06),
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
              color: favoritesProvider.isFavorite(widget.item) ? Colors.red : Colors.black,
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
