import 'package:flutter/material.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/View/Dashboard/Drawer/contactuspage.dart';
import 'package:store_app/View/Dashboard/SettingScreen/settinghome.dart';
import 'package:store_app/View/homescreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

 
 int _selectedIndex = 0;

  // Define your pages here
  final List<Widget> _pages = [
    // Your existing content
    HomeScreen(),
    ContactUsPage(),
    Profile(),
    // PlaceholderWidget(color: Colors.blue, text: 'Page 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: AppColors.primaryVariant, // Set background color here
            selectedItemColor: Colors.grey, // Set selected icon color
            unselectedItemColor: Colors.white, // Set unselected icon color
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Contact',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting',
              ),
            ],
          ),
        ),
      ),
    );
  }
}