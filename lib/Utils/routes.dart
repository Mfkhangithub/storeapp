import 'package:flutter/material.dart';
import 'package:store_app/Utils/routes_name.dart';
import 'package:store_app/View/SingInScreens/forgotscreen.dart';
import 'package:store_app/View/SingInScreens/singin_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final argume = settings.arguments;
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext) => LoginPage());
        case RoutesName.dash:
        // return MaterialPageRoute(builder: (BuildContext) => DashboardScreen());
        // case RoutesName.product:
        // return MaterialPageRoute(builder: (BuildContext) => ProductPage());
        case RoutesName.forg:
        return MaterialPageRoute(builder: (BuildContext) => ForgotPassword());
        // case RoutesName.profile:
        // return MaterialPageRoute(builder: (BuildContext) => OwnerProfile());
        // case RoutesName.showscreen:
        // return MaterialPageRoute(builder: (BuildContext) => Screenshow());
        // case RoutesName.notification:
        // return MaterialPageRoute(builder: (BuildContext) => NotificationPage());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text("No Route defind"),
            ),
          );
        });
    }
  }
}
