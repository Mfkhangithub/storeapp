import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Constant/foother.dart';
import 'package:store_app/Provider/Alllinks.dart';

class BecomePage extends StatefulWidget {
  const BecomePage({super.key});

  @override
  State<BecomePage> createState() => _BecomePageState();
}

class _BecomePageState extends State<BecomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Become a Vendor", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryVariant,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gutter(),
              Text(
                'Which categories do I offer for sale on FADII Store?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
              ),
              Gutter(),
              Text(
                'Selling your products on FADII Store is possible across a wide range of categories, particularly in cosmetics, skincare, health, and beauty. However, please note that we do not allow the sale of counterfeit or illegal goods. Vendors must ensure that all listed products comply with our quality standards and legal requirements.',
              ),
              Gutter(),
              Gutter(),
              Text(
                'What is the process of the FADII Store Vendor Center?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
              ),
              Gutter(),
              Text(
                'By registering your products and uploading them to the FADII Store online marketplace, you can sell products nationwide and receive orders directly into your account. This platform is designed specifically for FADII Store vendors to manage their listings and track their sales performance.',
              ),
              Gutter(),
              Gutter(),
              Text(
                'What is the commission structure on FADII Store?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
              ),
              Gutter(),
              Text(
                'Creating an account on FADII Store is completely free. However, we do charge a small commission on each sale. The commission percentage varies based on the category of the product. Detailed information about commission rates can be found in your vendor account.',
              ),
              Gutter(),
              Gutter(),
              Text(
                'Which documents are required to sell on FADII Store?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
              ),
              Gutter(),
              Text(
                'To start selling on FADII Store, individual sellers must submit the following documents:'
                '\n- CNIC (front and back images)'
                '\n- Bank Account Information'
                '\n- A copy of a blank cheque for verification purposes.',
              ),
              Gutter(),
              Gutter(),
              Text(
                'How do I upload my products to FADII Store?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
              ),
              Gutter(),
              Text(
                'After logging in, navigate to your FADII Store Vendor Center account, click on “Products” from the homepage, and select “Add Products.” Fill in all the required details about your product, including descriptions and images, then click “Submit.” Your product will be live on the marketplace shortly after approval.',
              ),
              Gutter(),
              Gutter(),
              Text(
                'What happens if false information is provided during registration?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
              ),
              Gutter(),
              Text(
                'Providing inaccurate or misleading information will result in the rejection of your application. Please ensure that all the details you provide are correct and match your legal documents (CNIC/NTN) to avoid any issues during the registration process.',
              ),
              Gutter(),
              Gutter(),
              Divider(),
              Gutter(),
              FooterWidget(provider: provider),
            ],
          ),
        ),
      ),
    );
  }
}
