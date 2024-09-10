import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Provider/Addtocard.dart';
import 'package:store_app/Utils/widget/roundbutoon.dart';
import 'package:url_launcher/url_launcher.dart';

class CartPage extends StatelessWidget {
  final String whatsappNumber = '+923018920989'; // Replace with your specific WhatsApp number

  // Method to generate WhatsApp message URL
  void _sendToWhatsApp(BuildContext context, CartState cartState) async {
    if (cartState.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No items to order')),
      );
      return;
    }

    // Construct the WhatsApp message with all items
    String message = 'Hello, I would like to order the following items:\n\n';

    for (var item in cartState.items) {
      message += 'Item Name: ${item.title}\n';
      message += 'Description: ${item.itemName}\n';
      message += 'Discount: ${item.discountedPrice}%\n';
      message += 'Original Price: ${item.price}\n\n';
    }

    final String whatsappUrl = 'https://wa.me/$whatsappNumber?text=${Uri.encodeComponent(message)}';

    // Check if WhatsApp is available and launch the URL
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open WhatsApp')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryVariant,
        title: Text('Cart', style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<CartState>(
        builder: (context, cartState, child) {
          // Check if cart is empty
          if (cartState.items.isEmpty) {
            return Center(
              child: Text(
                'There are no items selected',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            // Display cart items and order button
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartState.items.length,
                    itemBuilder: (context, index) {
                      final item = cartState.items[index];
                      return ListTile(
                        leading: Image.network(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(item.title),
                        subtitle: Text('${item.discountedPrice}% (Original: ${item.price})'),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () {
                            cartState.removeItem(item);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: RoundButton(
                    title: "Order Now",
                    onTap: () => _sendToWhatsApp(context, cartState),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
