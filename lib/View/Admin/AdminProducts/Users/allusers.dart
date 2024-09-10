import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/View/Admin/AdminProducts/Users/Shopcreation.dart';
import 'package:store_app/View/Admin/AdminProducts/Users/shopdetails.dart';

class AdminUserListScreen extends StatefulWidget {
  const AdminUserListScreen({Key? key}) : super(key: key);

  @override
  _AdminUserListScreenState createState() => _AdminUserListScreenState();
}

class _AdminUserListScreenState extends State<AdminUserListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryVariant,
        title: Text(
          "Registered Users",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong!"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No users found"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var user = snapshot.data!.docs[index];
              return Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(user['username']),
                    subtitle: Text(user['email']),
                    trailing: Column(children: [
                      Text(user['role']),
                      Gutter(),
                      GestureDetector(
                        child: Icon(Icons.shop))
                    ],),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShopCreationScreen(userId: user.id),
                        ),
                      );
                    },
                  ),
                  Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
