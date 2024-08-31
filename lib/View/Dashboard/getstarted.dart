import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/View/Admin/admindashboard.dart';
import 'package:store_app/View/Dashboard/dashboard.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key, required List<QueryDocumentSnapshot<Object?>> adminData});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String role = '';

  @override
  void initState() {
    super.initState();
    _getUserRole();
  }

  void _getUserRole() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        role = userDoc['role'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 110),
            Center(
              child: Image.asset("assets/shoping.jpeg"),
            ),
            Gutter(),
            TextButton(
              onPressed: () {
                if (role == 'Admin') {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDashboard()));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
                }
              },
              child: Text(
                "Welcome Here! Get Started",
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.5,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.double,
                  shadows: [BoxShadow(color: Colors.black, blurRadius: 3)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
