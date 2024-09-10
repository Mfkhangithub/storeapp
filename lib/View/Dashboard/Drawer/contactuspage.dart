import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Constant/foother.dart';
import 'package:store_app/Provider/Alllinks.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
   final double coverhight = 180;
  final double profileHight = 50;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Contact Us", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryVariant,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gutter(),
              Gutter(),
              Center(child: buildTop()),
              Gutter(),
              Gutter(),
              Gutter(),
              Gutter(),
              Gutter(),
              Center(
                child: Text(
                  'Contact Us For Any Questions',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Gutter(),
              Gutter(),
              Gutter(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.home,
                    size: 50,
                    color: AppColors.black,
                  ),
                  Gutter(),
                  Text(
                    'Office Address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Gutter(),
                  Center(
                    child: Text(
                      'Naguman Choki, Mian G Shopping Plaza',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Shabqadar Road, Shop #25, Naguman, Peshawar',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Gutter(),
                  Text(
                    '+92301-8920989',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Gutter(),
              Gutter(),
              Gutter(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email,
                    size: 60,
                    color: Color.fromARGB(255, 244, 106, 7),
                  ),
                  Gutter(),
                  Text(
                    'Email-Us',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Gutter(),
                  Center(
                    child: Text(
                      'fadii.store@gmail.com',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Gutter(),
              Gutter(),
              Gutter(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.whatsapp,
                    size: 60,
                    color: AppColors.darkColor,
                  ),
                  Gutter(),
                  Text(
                    'WhatsApp',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Gutter(),
                  Center(
                    child: Text(
                      '+92301-8920989',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Center(
                    child: Text(
                      '+92300-9356529',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Gutter(),
              Gutter(),
              Gutter(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.store,
                    size: 60,
                    color: AppColors.darkColor,
                  ),
                  Gutter(),
                  Text(
                    'Store Address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Gutter(),
                  Center(
                    child: Text(
                      'FADII Store',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Shop No 02, 03',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Mian G Market, Shabqadar Road, Peshawar',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Gutter(),
                  Center(
                    child: Text(
                      '+92301-8920989',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Center(
                    child: Text(
                      '+92300-9356529',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Gutter(),
              Gutter(),
              Divider(),
              Gutter(),
              Gutter(),
              Gutter(),
              FooterWidget(provider: provider),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTop(){
final top = coverhight - profileHight / 1;
  return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
           buildCovercontainer(),
           Positioned(
           top: top,
            child: buildCircularavatar()),
          
        ],
      );
 }
 Widget buildCovercontainer() =>  Container(
            height: 200,
            width: 350,
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'assets/back.png', // Replace this with the path to your asset image
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
            ),
            );
 Widget buildCircularavatar() => Container(
                      height: 130,
                      width: 130,
                     decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      color: Colors.blueGrey
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: CircleAvatar(
                        radius: profileHight / 2.5,
                        // backgroundColor: Colors.black,
                        backgroundImage: AssetImage("assets/pro.jpeg"),
                                           ),
                     ),
 );
}
