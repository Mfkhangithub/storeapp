import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Provider/themeprovider.dart';
import 'package:store_app/View/Dashboard/Drawer/TermandCondpage.dart';
import 'package:store_app/View/Dashboard/Drawer/contactuspage.dart';
import 'package:store_app/View/Dashboard/Drawer/privacypage.dart';
import 'package:store_app/View/SingInScreens/singin_screen.dart';

class AdminSettingsScreen extends StatefulWidget {
  @override
  _AdminSettingsScreenState createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;
  bool dataSyncEnabled = true;
  bool isLoading = false;

   void _logout() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print('Error logging out: $e');
      // Handle logout errors if necessary
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
     final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: AppColors.primaryVariant,
        title: Text(
          'Settings',
          // style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, 
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.all(16),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/fadii.jpg'), // Replace with your image
              ),
              title: Text('Muhammad Fahad', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Personal Information'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle navigation to profile details
              },
            ),
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
            title: 'Log Out',
            icon: Icons.logout,
            onTap: () {
              _logout();
              // Log out the admin
            },
            trailing: null,
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
