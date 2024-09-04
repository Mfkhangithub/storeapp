import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:store_app/Constant/categoriesclass.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Constant/imagesdilog.dart';
import 'package:store_app/Utils/widget/roundbutoon.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDetailScreen extends StatelessWidget {
  final GridItem item;
  final String whatsappNumber = '+923018920989'; // Replace with your specific WhatsApp number

  ItemDetailScreen({required this.item});

  // Method to generate WhatsApp message URL
  void _sendToWhatsApp(BuildContext context) async {
    final String message = 'Hello, I would like to order the following item:\n\n'
        'Item Name: ${item.title}\n'
        'Description: ${item.itemName}\n'
        'Discount: ${item.discountedPrice} %\n'
        'Original Price: ${item.price}';
        
    final String whatsappUrl = 'https://wa.me/$whatsappNumber?text=${Uri.encodeComponent(message)}';

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
        backgroundColor: AppColors.primaryVariant,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Item View", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: (){
                      showDialog(context: context, builder: (_) => ImageDialog(link: item.imageUrl));
                  },
                  child: Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16), // Rounded corners
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
                      borderRadius: BorderRadius.circular(16), // Same radius for the image to match the container
                      child:Image.network(item.imageUrl),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                item.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                item.itemName,
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
              SizedBox(height: 16),
              Text(
                'Original Price: ${item.price}',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              SizedBox(height: 8),
              Text(
                'Discount: ${item.discountedPrice} %',
                style: TextStyle(fontSize: 18, color: Colors.red, decoration: TextDecoration.lineThrough),
              ),
              Gutter(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: RoundButton(
                  title: "Order Now",
                  onTap: () => _sendToWhatsApp(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
