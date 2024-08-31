import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final Widget? sufficon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.validator, 
    this.sufficon,
     this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[400],
        
        prefixIcon: Icon(prefixIcon, color: Colors.black), // Icon color
        suffixIcon: sufficon,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black), // Hint text color
        errorStyle: TextStyle(color: Colors.red), // Error text color
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
        ),
      ),
      style: TextStyle(color: Colors.black), // Text color
      validator: validator,
      obscureText: obscureText,
       keyboardType: keyboardType,
    );
  }
}
