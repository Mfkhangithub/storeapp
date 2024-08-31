import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/Constant/Customdropdown.dart';
import 'package:store_app/Constant/GetInTouch.dart';
import 'package:store_app/Constant/navigationmethod.dart';
import 'package:store_app/Provider/Alllinks.dart';

class FooterWidget extends StatelessWidget {
  // final provider = Provider.of<ProviderController>(context, listen: false);
  final ProviderController provider; // Replace with your provider class name

  FooterWidget({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Us",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 16),
          Text("Call us 24/7"),
          SizedBox(height: 5),
          Text(
            "+923018920989",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                decoration: TextDecoration.underline),
          ),
          SizedBox(height: 5),
          Text("Mian G Shoping Plaza"),
          Text("Naguman, Peshawar"),
          Text(
            "fa8579364@gmail.com",
            style: TextStyle(decoration: TextDecoration.underline),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                SocialMediaIcon(
                  ontap: () async {
                    await provider.launchFacebookURL();
                  },
                  icon: FontAwesomeIcons.facebook,
                  color: Colors.blue,
                ),
                SocialMediaIcon(
                  ontap: () async {
                    await provider.launchtwiURL();
                  },
                  icon: FontAwesomeIcons.twitter,
                  color: Colors.blue,
                ),
                SocialMediaIcon(
                  ontap: () async {
                    await provider.launchtwiURL();
                  },
                  icon: FontAwesomeIcons.google,
                  color: Colors.red,
                ),
                SocialMediaIcon(
                  ontap: () async {
                    await provider.launchyoutubeURL();
                  },
                  icon: FontAwesomeIcons.youtube,
                  color: Colors.red,
                ),
                SocialMediaIcon(
                  ontap: () async {
                    await provider.launchInstagramURL();
                  },
                  icon: FontAwesomeIcons.instagram,
                  color: Colors.red,
                ),
                SocialMediaIcon(
                  ontap: () async {
                    await provider.launchwhatsappURLwithphone("+92-3018920989");
                  },
                  icon: FontAwesomeIcons.whatsapp,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Center(
            child: CustomDropdown(
              title: 'Quick Links',
              dropdownItems: ['Become a Vendor'],
              dropdownActions: [
                () => navigateToBecomeAVendor(context),
              ],
            ),
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Center(
            child: CustomDropdown(
              title: 'Company',
              dropdownItems: ['Privacy Policy', 'Terms of Use'],
              dropdownActions: [
                () => navigateToPrivacyPolicy(context),
                () => navigateToTermsOfUse(context),
              ],
            ),
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Center(
            child: CustomDropdown(
              title: 'Business',
              dropdownItems: ['About Us', 'Contact'],
              dropdownActions: [
                () => navigateToAboutUs(context),
                () => navigateToContact(context),
              ],
            ),
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 70),
          Center(
            child: Text("2024 FADII. All Rights Reserved"),
          ),
        ],
      ),
    );
  }
}