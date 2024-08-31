import 'package:flutter/material.dart';
import 'package:store_app/Provider/validation.dart';


class login extends ChangeNotifier {
  late validaitonitem _email = validaitonitem(null, null);
  late validaitonitem _password = validaitonitem(null, null);
  /////////////////////////////////
  //controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  /////////////////////////////////////////////

  //dispsoe the controller
  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  // Getters for validation errors
  validaitonitem get email => _email;
  validaitonitem get password => _password;



// Email validation function
    void validateEmail(String value) {
    if (value.isEmpty) {
      _email = validaitonitem(value, "Email is required!");
    } else if (!isValidEmail(value)) {
      _email = validaitonitem(value, 'Enter a valid email!');
    } else {
      _email = validaitonitem(value, null);
    }
    notifyListeners();
  }

  // Password validation function
  void validatePassword(String value) {
    if (value.isEmpty) {
      _password = validaitonitem(value, 'Password is required!');
    } else if (value.length < 6) {
      _password =
          validaitonitem(value, 'Password must be at least 6 characters long!');
    } else {
      _password = validaitonitem(value, null);
    }
    notifyListeners();
  }

  // bool isValidPhoneNumber(String phoneNumber) {
  //   final phoneRegExp = RegExp(r'^\@\d{10}$');
  //   return phoneRegExp.hasMatch(phoneNumber);
  // }

    bool isValidEmail(String email) {
    final emailRegExp = RegExp(
        r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
    return emailRegExp.hasMatch(email);
  }


  bool get isvalid {
    if (_email.Value != null &&
        _password.Value != null &&
        _email.error == null &&
        _password.error == null) {
      return true;
    } else {
      return false;
    }
  }
}
