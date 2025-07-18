import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Provider/themeprovider.dart';
import 'package:store_app/View/Admin/Firebasefirestore/profilepostscreen.dart';
import 'package:store_app/View/Dashboard/Drawer/TermandCondpage.dart';
import 'package:store_app/View/Dashboard/Drawer/contactuspage.dart';
import 'package:store_app/View/Dashboard/Drawer/privacypage.dart';
import 'package:store_app/View/SingInScreens/singin_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _DarkPagesState();
}

class _DarkPagesState extends State<Profile> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;
  bool dataSyncEnabled = true;
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
    isLoading = true; // Trigger UI update to show loading indicator
  });

  try {
    // Sign out from Firebase
    await FirebaseAuth.instance.signOut();

    // After sign out completes, navigate to the login page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false, // Removes all previous routes
    );
  } catch (e) {
    print('Error logging out: $e');
    // Show an error message if sign-out fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error logging out. Please try again.')),
    );
  } finally {
    setState(() {
      isLoading = false; // Hide the loading spinner after the operation
    });
  }
}

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
      ),
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
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

            return Card(
            margin: EdgeInsets.all(16),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
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
                  ), // Replace with your image
              title: Text(data['username'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Personal Information'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle navigation to profile details
              },
            ),
          );
          } else {
            return Center(child: Text("No Profile Found"));
          }
        },
      ),
          _buildSectionHeader('GENERAL'),
          _buildSettingsTile(
            title: 'Notifications',
            icon: Icons.notifications,
            trailing: CupertinoSwitch(
              value: notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.w500)),
            leading: Icon(Icons.nightlight_round, color: Colors.blue),
            trailing: Switch(
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (bool value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),
          Divider(),
          _buildSectionHeader('ACCOUNT'),
          _buildSettingsTile(
            title: 'Edit Profile',
            icon: Icons.person,
            onTap: () {
              // Navigate to edit profile screen
               Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirestoreProfilePostscreen()),
                  );
            },
          ),
          _buildSettingsTile(
            title: 'Change Password',
            icon: Icons.lock,
            onTap: () {
              // Navigate to change password screen
            },
          ),
          Divider(),
          _buildSectionHeader('DATA & PRIVACY'),
          _buildSettingsTile(
            title: 'Data Sync',
            icon: Icons.sync,
            trailing: CupertinoSwitch(
              value: dataSyncEnabled,
              onChanged: (bool value) {
                setState(() {
                  dataSyncEnabled = value;
                });
              },
            ),
          ),
          _buildSettingsTile(
            title: 'Privacy Policy',
            icon: Icons.security,
            onTap: () {
              // Navigate to privacy policy screen
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PrivacyPage()));
            },
          ),
          Divider(),
          _buildSectionHeader('SUPPORT'),
          _buildSettingsTile(
            title: 'Help & Support',
            icon: Icons.help,
            onTap: () {
              // Navigate to support screen
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactUsPage()));
            },
          ),
          _buildSettingsTile(
            title: 'Terms & Conditions',
            icon: Icons.description,
            onTap: () {
              // Navigate to terms screen
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TermCondPage()));
            },
          ),
          Divider(),
          _buildSettingsTile(
            title: isLoading ? 'Logging out...' : 'Log Out',
          icon: Icons.logout,
          onTap: isLoading ? null : _logout, // Disable button when loading
          trailing: isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : null,
          textColor: Colors.red,
        ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required IconData icon,
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      leading: Icon(icon, color: Colors.blue),
      trailing: trailing ?? Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: onTap,
    );
  } 
  }
