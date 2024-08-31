import 'package:flutter/material.dart';
import 'package:store_app/SplashScreen/Splashservices.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashscreen = SplashServices();
  @override
  void initState() {
    super.initState();
   splashscreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images.png")
      ),
    );
  }
}
