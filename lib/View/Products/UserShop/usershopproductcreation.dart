import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Utils/utils.dart';

class ShopProductCreationScreen extends StatefulWidget {
  final String shopId;
  final String userId;

  const ShopProductCreationScreen({Key? key, required this.shopId, required this.userId}) : super(key: key);

  @override
  _ShopProductCreationScreenState createState() => _ShopProductCreationScreenState();
}

class _ShopProductCreationScreenState extends State<ShopProductCreationScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool loading = false;
  final namecontroller = TextEditingController();
  final discontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  final discripcontroller = TextEditingController();

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
    final pickedFile = await picker.pickImage(source: ImageSource.camera,imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Utils().toasMessage("No image selected");
      }
    });
  }


  Future<String?> _uploadImage(File image) async {
    try {
      String id = DateTime.now().microsecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance.ref().child('product_images').child(id);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      Utils().toasMessage("Failed to upload image: $e");
      return null;
    }
  }

  Future<void> _createProduct() async {
    if (_image == null) {
      Utils().toasMessage("Please select an image");
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      String? imageUrl = await _uploadImage(_image!);
      if (imageUrl == null) {
        throw Exception("Image upload failed");
      }

      await _firestore.collection('shops').doc(widget.shopId).collection('products').add({
        'title': namecontroller.text.trim(),
        'price': pricecontroller.text.trim(),
        'description': discripcontroller.text.trim(),
        'discount': discontroller.text.trim(),
        'imageUrl': imageUrl,
      });

      Utils().toasMessage('Product created successfully!');
      Navigator.pop(context);
    } catch (error) {
      Utils().toasMessage('Failed to create product: $error');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    namecontroller.dispose();
    pricecontroller.dispose();
    discontroller.dispose();
    discripcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryVariant,
        title: Text("Create Products", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
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
              SizedBox(height: 16),
              TextField(
                controller: namecontroller,
                decoration: InputDecoration(labelText: "Product Name"),
              ),
              TextField(
                controller: discripcontroller,
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3,
              ),
               TextField(
                controller: pricecontroller,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ), TextField(
                controller: discontroller,
                decoration: InputDecoration(labelText: "Discount Price"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: loading ? null : _createProduct,
                child: loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Create Product",style: TextStyle(color: Colors.white), ),
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
