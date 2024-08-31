import 'package:flutter/material.dart';
import 'package:store_app/Constant/colorpage.dart';

class ForgotPassword extends StatelessWidget {
  static const String id = 'forgot-password'; // Route ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.grey
                ),
                height: 300,
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                        Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 30, color: Colors.black),
                                ),
                                TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(
                      Icons.mail,
                      color: Colors.black,
                    ),
                    errorStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton( // Updated widget name
                                    style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryVariant, // Change the background color of the button
  ),
                  child: Text('Send Email', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    // Implement logic to send reset password email
                  },
                                ),
                                ElevatedButton(
                                   style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryVariant, // Change the background color of the button
  ),
                  child: Text('Sign In', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    // Navigate back to the sign-in screen
                    Navigator.pop(context);
                  },
                                ),
                    ],
                  ),
                )
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
