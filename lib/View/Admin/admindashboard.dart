import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/View/Admin/AdminProducts/Category/Managecategories.dart';
import 'package:store_app/View/Admin/AdminProducts/Category/categoriesdashb.dart';
import 'package:store_app/View/Admin/AdminProducts/Users/allusers.dart';
import 'package:store_app/View/Dashboard/showshops.dart';
import 'package:store_app/View/SingInScreens/singin_screen.dart';


class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
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
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryVariant,
        title: Text('Admin Dashboard', style: TextStyle(color: AppColors.white)),
        centerTitle: true,
         actions: [IconButton(onPressed: (){
          _logout();
        }, icon: Icon(Icons.logout, color: Colors.white,))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            DashboardCard(
              title: 'Add Product',
              icon: Icons.add_box,
              colors: const Color.fromARGB(255, 3, 139, 7),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen()));
              },
            ),
            DashboardCard(
              title: 'Manage Products',
              icon: Icons.inventory,
              colors: const Color.fromARGB(255, 210, 127, 2),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryMangScreen()));
              },
            ),
            DashboardCard(
              title: 'Manage Users',
              icon: Icons.people,
              colors: Colors.black,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdminUserListScreen()));
              },
            ),
            DashboardCard(
              title: 'Orders',
              icon: Icons.shopping_cart,
              colors: AppColors.primaryVariant,
              onTap: () {
                // Implement orders screen
                Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => ShopsListScreen()),
);
              },
            ),
            DashboardCard(
              title: 'Reports',
              icon: Icons.bar_chart,
              colors: const Color.fromARGB(255, 201, 15, 2),
              onTap: () {
                // Implement reports screen
              },
            ),
            DashboardCard(
              title: 'Settings',
              icon: Icons.settings,
              colors: Colors.black,
              onTap: () {
                // Implement settings screen
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
