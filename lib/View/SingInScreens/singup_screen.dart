import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Provider/validation.dart';
import 'package:store_app/Utils/utils.dart';
import 'package:store_app/Utils/widget/Customtextfiled.dart';
import 'package:store_app/Utils/widget/roundbutoon.dart';
import 'package:store_app/View/SingInScreens/singin_screen.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;
  String _selectedRole = 'User'; // Default role
  int _tapCount = 0; // Counter to track the number of taps
  List<String> _roles = ['User']; // Initially, only 'User' is shown
  bool _obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onDropdownTap() {
    _tapCount++; // Increment tap count on each tap

    if (_tapCount == 5) {
      setState(() {
        _roles.add('Admin'); // Add 'Admin' after three taps
      });
    }
  }

  void register() async {
    setState(() {
      loading = true;
    });

    try {
      if (_selectedRole == 'Admin') {
        // Check if an admin already exists
        QuerySnapshot adminSnapshot = await _firestore
            .collection('users')
            .where('role', isEqualTo: 'Admin')
            .get();

        if (adminSnapshot.docs.isNotEmpty) {
          // Admin already exists, show a message and return
          Utils().toasMessage('An admin already exists. Only one admin is allowed.');
          setState(() {
            loading = false;
          });
          return;
        }
      }

      // Continue with user registration
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': nameController.text.trim(),
          'email': emailController.text.trim(),
          'phone': phoneController.text.trim(),
          'uid': userCredential.user!.uid,
          'role': _selectedRole,
        });

        Utils().toasMessage('Account created successfully!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (error) {
      Utils().toasMessage(error.toString());
    } finally {
      setState(() {
        loading = false;
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
        centerTitle: true,
        title: Text('Sign Up', style: TextStyle(color: AppColors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 130),
                CustomTextField(
                  controller: nameController,
                  hintText: "User Name",
                  prefixIcon: Icons.person,
                  validator: ValidationUtils.validateName,
                ),
                Gutter(),
                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: Icons.email,
                  validator: ValidationUtils.validateEmail,
                ),
                Gutter(),
                CustomTextField(
                  controller: phoneController,
                  hintText: "Phone",
                  prefixIcon: Icons.phone,
                  validator: ValidationUtils.validatePhone,
                ),
                Gutter(),
                ValueListenableBuilder(
                  valueListenable: ValueNotifier<bool>(true),
                  builder: (context, value, child) {
                    return CustomTextField(
                      controller: passwordController,
                      hintText: "Password",
                      prefixIcon: Icons.lock,
                      validator: ValidationUtils.validatePassword,
                      obscureText: _obscureText,
                      sufficon: IconButton(
                        icon: Icon(
                          _obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    );
                  },
                ),
                Gutter(),
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  items: _roles.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRole = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: "Select Role",
                  ),
                  onTap: _onDropdownTap, // Attach the tap handler
                ),
                Gutter(),
                RoundButton(
                  title: "Register",
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      register();
                    }
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: TextStyle(color: AppColors.black, fontSize: 15)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: Text("Login", style: TextStyle(color: AppColors.primaryVariant, fontSize: 18)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
