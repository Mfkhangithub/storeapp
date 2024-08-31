import 'package:flutter/material.dart';
import 'package:store_app/View/Dashboard/Drawer/TermandCondpage.dart';
import 'package:store_app/View/Dashboard/Drawer/aboutuspage.dart';
import 'package:store_app/View/Dashboard/Drawer/becomeapage.dart';
import 'package:store_app/View/Dashboard/Drawer/contactuspage.dart';
import 'package:store_app/View/Dashboard/Drawer/privacypage.dart';

void navigateToBecomeAVendor(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BecomePage()),
  );
}

void navigateToPrivacyPolicy(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PrivacyPage()),
  );
}

void navigateToTermsOfUse(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => TermCondPage()),
  );
}

void navigateToAboutUs(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AboutUsPage()),
  );
}

void navigateToContact(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ContactUsPage()),
  );
}