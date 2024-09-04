import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Utils/utils.dart';

class EditProductScreen extends StatefulWidget {
  final String shopId;
  final String productId;

  const EditProductScreen({Key? key, required this.shopId, required this.productId}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final discountController = TextEditingController();

  File? _image;
  final picker = ImagePicker();
  String? _imageUrl; // Store image URL

  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  Future<void> _loadProductData() async {
    final product = await FirebaseFirestore.instance
        .collection('shops')
        .doc(widget.shopId)
        .collection('products')
        .doc(widget.productId)
        .get();

    if (product.exists) {
      nameController.text = product['name'];
      priceController.text = product['price'];
      descriptionController.text = product['description'];
      discountController.text = product['discount'];
      _imageUrl = product['imageUrl']; // Fetch the image URL

      // Trigger a rebuild if URL is available
      setState(() {});
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      Utils().toasMessage("No image selected");
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      Utils().toasMessage("No image selected");
    }
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

  Future<void> _updateProduct() async {
    try {
      String? imageUrl;
      if (_image != null) {
        imageUrl = await _uploadImage(_image!);
        if (imageUrl == null) {
          throw Exception("Image upload failed");
        }
      } else {
        // If no new image is selected, use the old image URL
        imageUrl = _imageUrl;
      }

      await FirebaseFirestore.instance
          .collection('shops')
          .doc(widget.shopId)
          .collection('products')
          .doc(widget.productId)
          .update({
        'name': nameController.text,
        'price': priceController.text,
        'description': descriptionController.text,
        'discount': discountController.text,
        if (imageUrl != null) 'imageUrl': imageUrl,
      });
      Utils().toasMessage('Product updated successfully!');
      Navigator.pop(context);
    } catch (error) {
      Utils().toasMessage('Failed to update product: $error');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryVariant,
        title: Text("Edit Product", style: TextStyle(color: Colors.white)),
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
                            errorBuilder: (context, error, stackTrace) => Center(child: Text("Failed to load image")),
                          ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              TextField(
                controller: discountController,
                decoration: InputDecoration(labelText: 'Discount Price'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProduct,
                child: Text("Save Changes", style: TextStyle(color: Colors.white)),
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
