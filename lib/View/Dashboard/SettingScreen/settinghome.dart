import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  // Stream to listen to the current user's profile data
  final Stream<QuerySnapshot> fireStore = FirebaseFirestore.instance
      .collection("users")
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .snapshots();

  bool isLoading = false;
  bool showSocialMediaRow = false;

  // Logout Function
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
        (Route<dynamic> route) => false, // Removes all previous routes
      );
    } catch (e) {
      print('Error logging out: $e');
      // Optionally, show a snackbar or dialog to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out. Please try again.')),
      );
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
        title: Text(
          "Settings",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primaryVariant,
        centerTitle: true,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: AppColors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'profile') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirestoreProfilePostscreen()),
                  );
                } else if (value == 'Logout') {
                  _logout();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'profile',
                  child: Text('Update Profile'),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStore,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          // Handle errors
          if (snapshot.hasError) return Center(child: Text("An error occurred"));

          // Check if data exists
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            var doc = snapshot.data!.docs.first;
            var data = doc.data() as Map<String, dynamic>;

            // Extract imageUrl from data
            String? imageUrl = data['imageUrl'];

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  // CircleAvatar with conditional image display
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primaryVariant,
                    backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                        ? NetworkImage(imageUrl)
                        : null,
                    child: imageUrl == null || imageUrl.isEmpty
                        ? Icon(
                            Icons.person,
                            size: 50,
                            color: AppColors.white,
                          )
                        : null,
                  ),
                  SizedBox(height: 20),
                  // Display Username
                  Text(
                    data['username'] ?? 'No Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    indent: 90,
                    endIndent: 90,
                    color: AppColors.black,
                  ),
                  SizedBox(height: 10),
                  // Display Email
                  Text(
                    data['email'] ?? 'No Email',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Display Phone Number
                  Text(
                    data['phone'] ?? 'No Phone Number',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Social Media Toggle
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showSocialMediaRow = !showSocialMediaRow;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        showSocialMediaRow
                            ? 'Click to hide social media'
                            : 'Click to see social media',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  // Social Media Icons
                  Visibility(
                    visible: showSocialMediaRow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Replace with your social media links or actions
                        GestureDetector(
                          onTap: () {
                            // Handle Google action
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/google.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        Gutter(),
                        GestureDetector(
                          onTap: () {
                            // Handle Facebook action
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/fb.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        Gutter(),
                        GestureDetector(
                          onTap: () {
                            // Handle YouTube action
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/youtube.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        Gutter(),
                        GestureDetector(
                          onTap: () {
                            // Handle LinkedIn action
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/link.jpg",
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        Gutter(),
                        GestureDetector(
                          onTap: () {
                            // Handle Instagram action
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/insta.jpg",
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        Gutter(),
                        GestureDetector(
                          onTap: () {
                            // Handle GitHub action
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/github.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 70),
                ],
              ),
            );
          } else {
            return Center(child: Text("No Profile Found"));
          }
        },
      ),
    );
  }
}
