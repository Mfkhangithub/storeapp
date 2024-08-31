import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/View/Admin/Firebasefirestore/profilepostscreen.dart';
import 'package:store_app/View/SingInScreens/singin_screen.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _DarkPagesState();
}

class _DarkPagesState extends State<Profile> {
  final fireStore = FirebaseFirestore.instance
      .collection("users")
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .snapshots();

  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;
  bool showSocialMediaRow = false;

  void _logout() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false, // This will remove all the previous routes
      );
    } catch (e) {
      print('Error logging out: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryVariant,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: AppColors.white),
        centerTitle: true,
        title: Text("Setting", style: TextStyle(color: AppColors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'profile') {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FirestoreProfilePostscreen()));
                } else if (value == 'Logout') {
                  _logout();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'profile',
                  child: Text('Create Profile'),
                ),
                PopupMenuItem<String>(
                  value: 'Logout',
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return CircularProgressIndicator();
              if (snapshot.hasError) return Text("Some Error");

              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                var doc = snapshot.data!.docs.first;
                var data = doc.data() as Map<String, dynamic>;

                return Column(
                  children: [
                    SizedBox(height: 30),
                    CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50, color: AppColors.white),
                      backgroundColor: AppColors.primaryVariant,
                    ),
                    SizedBox(height: 20),
                    Text(
                      data['username'] ?? 'No Name',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.black),
                    ),
                    Divider(
                      thickness: 2,
                      indent: 90,
                      endIndent: 90,
                      color: AppColors.black,
                    ),
                     SizedBox(height: 10),
                    Text(
                      data['email'] ?? 'No Email',
                      style: TextStyle(fontSize: 18, color: AppColors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      data['phone'] ?? 'No Phone Number',
                      style: TextStyle(fontSize: 18, color: AppColors.black),
                    ),
                    SizedBox(height: 30),
                  ],
                );
              } else {
                return Center(child: Text("No Profile Found"));
              }
            },
          ),
          SizedBox(height: 70),
          GestureDetector(
            onTap: () {
              setState(() {
                showSocialMediaRow = !showSocialMediaRow;
              });
            },
            child: Visibility(
              visible: !showSocialMediaRow, // Inverted visibility to show initially
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Click to see social media',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: showSocialMediaRow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/google.png", height: 40, width: 40),
                ),
                Gutter(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/fb.png", height: 40, width: 40),
                ),
                Gutter(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/youtube.png", height: 40, width: 40),
                ),
                Gutter(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/link.jpg", height: 40, width: 40),
                ),
                Gutter(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/insta.jpg", height: 40, width: 40),
                ),
                Gutter(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/github.png", height: 40, width: 40),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}