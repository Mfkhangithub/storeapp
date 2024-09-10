import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:store_app/Constant/colorpage.dart';

class UpdateShopScreen extends StatefulWidget {
  final String shopId;

  UpdateShopScreen({required this.shopId});

  @override
  _UpdateShopScreenState createState() => _UpdateShopScreenState();
}

class _UpdateShopScreenState extends State<UpdateShopScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final _formKey = GlobalKey<FormState>();

  // Form fields controllers
  TextEditingController _marketNameController = TextEditingController();
  TextEditingController _shopNameController = TextEditingController();
  TextEditingController _shopNumberController = TextEditingController();

  File? _selectedImage; // Holds the selected image file
  String? _imageUrl; // Holds the uploaded image URL
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadShopDetails();
  }

  // Function to load shop details from Firestore
  void _loadShopDetails() async {
    setState(() {
      _isLoading = true;
    });

    try {
      DocumentSnapshot shopDoc = await _firestore.collection('shops').doc(widget.shopId).get();

      if (shopDoc.exists) {
        _marketNameController.text = shopDoc['marketName'] ?? '';
        _shopNameController.text = shopDoc['shopName'] ?? '';
        _shopNumberController.text = shopDoc['shopNumber'] ?? '';
        _imageUrl = shopDoc['imageUrl'] ?? '';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error loading shop details: $e'),
      ));
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Function to upload image to Firebase Storage
  Future<String?> _uploadImage(File image) async {
    try {
      String fileName = 'shops/${widget.shopId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      UploadTask uploadTask = _storage.ref().child(fileName).putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error uploading image: $e'),
      ));
      return null;
    }
  }

  // Function to update the shop details in Firestore
  void _updateShopDetails() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        String? imageUrl;

        // If a new image is selected, upload it
        if (_selectedImage != null) {
          imageUrl = await _uploadImage(_selectedImage!);
        }

        // If no new image is selected, keep the old image URL
        await _firestore.collection('shops').doc(widget.shopId).update({
          'marketName': _marketNameController.text,
          'shopName': _shopNameController.text,
          'shopNumber': _shopNumberController.text,
          'imageUrl': imageUrl ?? _imageUrl, // Use new image URL or keep the old one
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Shop updated successfully!'),
        ));
        Navigator.of(context).pop(); // Close the update screen
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update shop: $e'),
        ));
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _marketNameController.dispose();
    _shopNameController.dispose();
    _shopNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryVariant,
        title: Text("Update Shop", style: TextStyle(color: Colors.white)),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    if (_selectedImage != null)
                      Image.file(_selectedImage!, height: 150)
                    else if (_imageUrl != null)
                      Image.network(_imageUrl!, height: 150)
                    else
                      Text("No Image Available"),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text("Pick Image from Gallery"),
                    ),
                    TextFormField(
                      controller: _marketNameController,
                      decoration: InputDecoration(labelText: "Market Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the market name";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _shopNameController,
                      decoration: InputDecoration(labelText: "Shop Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the shop name";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _shopNumberController,
                      decoration: InputDecoration(labelText: "Shop Number"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the shop number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _updateShopDetails,
                      child: Text("Update Shop"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
