import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:store_app/Provider/Addtocard.dart';
import 'package:store_app/Provider/Alllinks.dart';
import 'package:store_app/Provider/favoriteprovider.dart';
import 'package:store_app/Provider/loginprovider.dart';
import 'package:store_app/Provider/themeprovider.dart';
import 'package:store_app/SplashScreen/Splachscreen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
              ChangeNotifierProvider(create: (context) => login()),
              ChangeNotifierProvider(create: (context) => ProviderController()),
              ChangeNotifierProvider(create: (context) => CartState()),
              ChangeNotifierProvider(create: (_) => FavoritesProvider()),
              ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ],
      child: Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Admin Settings',
          theme: ThemeData.light(), // Define your light theme
          darkTheme: ThemeData.dark(), // Define your dark theme
          themeMode: themeProvider.themeMode, // Use themeMode from provider
          home: SplashScreen(),
        );
      },
    ));
  }
}