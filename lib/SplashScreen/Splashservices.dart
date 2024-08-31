import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store_app/View/Admin/admindashboard.dart';
import 'package:store_app/View/Dashboard/dashboard.dart';
import 'package:store_app/View/SingInScreens/singin_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      // Fetch user role from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      String role = userDoc['role'];

      // Navigate based on role
      Timer(Duration(seconds: 3), () {
        if (role == 'Admin') {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => AdminDashboard(), // Admin dashboard
          ));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => DashboardScreen(), // User dashboard
          ));
        }
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginPage(), // Login screen
        ));
      });
    }
  }
}
