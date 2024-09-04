import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Utils/utils.dart';

class ShopCreationScreen extends StatefulWidget {
  final String userId;

  const ShopCreationScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ShopCreationScreenState createState() => _ShopCreationScreenState();
}

class _ShopCreationScreenState extends State<ShopCreationScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController marketNameController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopNumberController = TextEditingController();
  bool loading = false;

  File? _image;
  final picker = ImagePicker();

  // Function to pick image from the gallery
  Future pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Utils().toasMessage("No image selected");
      }
    });
  }

  // Function to pick image from the camera
  Future pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Utils().toasMessage("No image selected");
      }
    });
  }

  // Function to upload image to Firebase Storage and get the URL
  Future<String> uploadImage(File image) async {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('shop_images')
        .child(id);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  @override
  void dispose() {
    marketNameController.dispose();
    shopNameController.dispose();
    shopNumberController.dispose();
    super.dispose();
  }

  void createShop() async {
    setState(() {
      loading = true;
    });

    String? imageUrl;

    if (_image != null) {
      // Upload image if one is selected
      imageUrl = await uploadImage(_image!);
    }

    try {
      await _firestore.collection('shops').add({
        'userId': widget.userId,
        'marketName': marketNameController.text.trim(),
        'shopName': shopNameController.text.trim(),
        'shopNumber': shopNumberController.text.trim(),
        'imageUrl': imageUrl, // Add image URL to the shop data
      });

      Utils().toasMessage('Shop created successfully!');
      Navigator.pop(context); // Go back to the previous screen
    } catch (error) {
      Utils().toasMessage('Failed to create shop: $error');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryVariant,
        title: Text("Create Shop", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.photo_library),
                            title: Text('Pick from Gallery'),
                            onTap: () {
                              pickImageFromGallery();
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text('Take a Photo'),
                            onTap: () {
                              pickImageFromCamera();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: _image == null
                    ? Container(
                        color: Colors.grey[200],
                        height: 150,
                        width: double.infinity,
                        child: Center(child: Text("Select Image", style: TextStyle(color: Colors.grey))),
                      )
                    : Image.file(
                        _image!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: marketNameController,
                decoration: InputDecoration(labelText: "Market Name"),
              ),
              TextField(
                controller: shopNameController,
                decoration: InputDecoration(labelText: "Shop Name"),
              ),
              TextField(
                controller: shopNumberController,
                decoration: InputDecoration(labelText: "Shop Number"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: loading ? null : createShop,
                child: loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Create Shop", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryVariant,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
