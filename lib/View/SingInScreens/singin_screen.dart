import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Utils/utils.dart';
import 'package:store_app/Utils/widget/Customtextfiled.dart';
import 'package:store_app/Utils/widget/roundbutoon.dart';
import 'package:store_app/View/Dashboard/getstarted.dart';
import 'package:store_app/View/SingInScreens/forgotscreen.dart';
import 'package:store_app/View/SingInScreens/singup_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;
  bool _obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

void _login() async {
  setState(() {
    loading = true;
  });

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (userCredential.user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();

      if (userDoc.exists) {
        String role = userDoc['role'] ?? ''; // Default to empty string if 'role' is not present

        if (role == 'Admin') {
           QuerySnapshot adminSnapshot = await _firestore.collection('adminData').get();
            List<QueryDocumentSnapshot<Object?>> adminData = adminSnapshot.docs;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetStarted(adminData: adminData)));
        } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetStarted(adminData: [])));
        }
      } else {
        Utils().toasMessage('User document does not exist');
      }
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
        backgroundColor: AppColors.primaryVariant,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Login', style: TextStyle(color: AppColors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 220),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: CupertinoIcons.mail,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
                Gutter(),
                ValueListenableBuilder(
                  valueListenable: ValueNotifier<bool>(true),
                  builder: (context, value, child) {
                    return CustomTextField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      hintText: "Password",
                      prefixIcon: CupertinoIcons.lock,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    );
                  },
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 255),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(fontSize: 14, color: AppColors.black),
                    ),
                  ),
                ),
                Gutter(),
                RoundButton(
                  title: "Login",
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: AppColors.black, fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SingUpScreen()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: AppColors.primaryVariant, fontSize: 18),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
