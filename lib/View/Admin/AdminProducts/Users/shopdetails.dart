import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Utils/utils.dart';

class ShopDetailsScreen extends StatefulWidget {
  final String shopId;

  const ShopDetailsScreen({Key? key, required this.shopId}) : super(key: key);

  @override
  _ShopDetailsScreenState createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController marketNameController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopNumberController = TextEditingController();
  bool loading = false;

  File? _image;
  String? _imageUrl;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadShopDetails();
  }

  Future _loadShopDetails() async {
    DocumentSnapshot shopDoc = await _firestore.collection('shops').doc(widget.shopId).get();
    var shopData = shopDoc.data() as Map<String, dynamic>;

    setState(() {
      marketNameController.text = shopData['marketName'] ?? '';
      shopNameController.text = shopData['shopName'] ?? '';
      shopNumberController.text = shopData['shopNumber'] ?? '';
      _imageUrl = shopData['imageUrl'];
    });
  }

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

  Future<String?> uploadImage(File image) async {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('shop_images')
        .child(id);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  void updateShop() async {
    setState(() {
      loading = true;
    });

    String? imageUrl;

    if (_image != null) {
      imageUrl = await uploadImage(_image!);
    } else {
      imageUrl = _imageUrl;
    }

    try {
      await _firestore.collection('shops').doc(widget.shopId).update({
        'marketName': marketNameController.text.trim(),
        'shopName': shopNameController.text.trim(),
        'shopNumber': shopNumberController.text.trim(),
        'imageUrl': imageUrl,
      });

      Utils().toasMessage('Shop updated successfully!');
      Navigator.pop(context); // Go back to the previous screen
    } catch (error) {
      Utils().toasMessage('Failed to update shop: $error');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void deleteShop() async {
    setState(() {
      loading = true;
    });

    try {
      // Delete shop image from Firebase Storage if it exists
      if (_imageUrl != null) {
        Reference ref = FirebaseStorage.instance.refFromURL(_imageUrl!);
        await ref.delete();
      }

      // Delete shop document from Firestore
      await _firestore.collection('shops').doc(widget.shopId).delete();

      Utils().toasMessage('Shop deleted successfully!');
      Navigator.pop(context); // Go back to the previous screen
    } catch (error) {
      Utils().toasMessage('Failed to delete shop: $error');
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
        title: Text("Shop Details", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.deepOrange,),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Delete Shop'),
                    content: Text('Are you sure you want to delete this shop?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          deleteShop();
                          Navigator.pop(context);
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              child: _image == null && _imageUrl == null
                  ? Container(
                      color: Colors.grey[200],
                      height: 150,
                      width: double.infinity,
                      child: Center(child: Text("Select Image", style: TextStyle(color: Colors.grey))),
                    )
                  : _image != null
                      ? Image.file(
                          _image!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          _imageUrl!,
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
              onPressed: loading ? null : updateShop,
              child: loading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Update Shop", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryVariant,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
