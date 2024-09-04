import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/View/Products/UserShop/usereditproduct.dart';
import 'package:store_app/View/Products/UserShop/usershopproductcreation.dart';
import 'package:store_app/View/SingInScreens/singin_screen.dart'; // Login Page

class UserDashboard extends StatefulWidget {
  final String shopId;
  final String userId;

  const UserDashboard({Key? key, required this.shopId, required this.userId}) : super(key: key);


  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
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
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryVariant,
        title: Text('User Dashboard', style: TextStyle(color: AppColors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            DashboardCard(
              title: 'Create Product',
              icon: Icons.add,
              colors: const Color.fromARGB(255, 3, 139, 7),
              onTap: () {
              Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShopProductCreationScreen(
          shopId: widget.shopId, // use widget.shopId here
          userId: widget.userId, // use widget.userId here
        ),
      ),
    );
              },
            ),
            DashboardCard(
              title: 'Manage Product',
              icon: Icons.manage_accounts,
              colors: const Color.fromARGB(255, 210, 127, 2),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserEditProductScreen(shopId: widget.shopId,)));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color colors;

  const DashboardCard({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: colors),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
