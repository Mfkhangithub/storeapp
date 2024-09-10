import 'package:flutter/material.dart';

class OrderButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'Product Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orangeAccent,
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
                    print('Order button pressed');
                  },
                  icon: Icon(Icons.shopping_cart_outlined),
                  iconSize: 30,
                  color: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  tooltip: 'Order Now',
                  splashRadius: 25,
                  splashColor: Colors.orangeAccent,
                  highlightColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
