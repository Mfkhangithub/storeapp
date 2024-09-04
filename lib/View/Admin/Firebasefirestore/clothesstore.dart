import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Utils/utils.dart';
import 'package:store_app/Utils/widget/roundbutoon.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:store_app/View/Admin/AdminProducts/Category/Clothes/clotheseditpage.dart';

class FirestoreClothesPostscreen extends StatefulWidget {
  const FirestoreClothesPostscreen({super.key});

  @override
  State<FirestoreClothesPostscreen> createState() => _FirestorePostscreenState();
}

class _FirestorePostscreenState extends State<FirestoreClothesPostscreen> {
  final namecontroller = TextEditingController();
  final discontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  final discripcontroller = TextEditingController();


  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection("clothesdata");
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

  // Function to upload image to Firebase Storage and get the URL
  Future<String> uploadImage(File image) async {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('postclothes_images')
        .child(id);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: AppColors.primaryVariant,
      title: Text("Clothes Post", style: TextStyle(color: Colors.white),
      ),),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
              SizedBox(height: 30),
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
            SizedBox(height: 30,),
            TextFormField(
              controller: namecontroller,
              decoration: InputDecoration(
                hintText: "Product Name",
                border: OutlineInputBorder()
              ),
            ),
            Gutter(),
            TextFormField(
              controller: pricecontroller,
              decoration: InputDecoration(
                hintText: "Price",
                border: OutlineInputBorder()
              ),
            ),
             Gutter(),
            TextFormField(
              controller: discontroller,
              decoration: InputDecoration(
                hintText: "Discount Price",
                border: OutlineInputBorder()
              ),
            ),
             Gutter(),
            TextFormField(
              maxLines: 4,
              controller: discripcontroller,
              decoration: InputDecoration(
                hintText: "Product Description",
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30),
            RoundButton(
       //         loading: loading,
                title: "Add",
                onTap: () async {
    if (_image == null) {
      Utils().toasMessage("Please select an image");
      return;
    }
    setState(() {
      loading = true;
    });
    // Show dialog with circular progress indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: CircularProgressIndicator()),
          content: Text("Adding Post..."),
            
        );
      },
    );

    try {
      String imageUrl = await uploadImage(_image!);
      String id = DateTime.now().microsecondsSinceEpoch.toString();
      await fireStore.doc(id).set({
        'title': namecontroller.text.toString(),
        'id': id,
        'imageUrl': imageUrl,
        'price': pricecontroller.text.toString(),
        'discount': discontroller.text.toString(),
        'description': discripcontroller.text.toString(),
      });

      // Dismiss the dialog
      Navigator.of(context).pop();

      // Show success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Post Added"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to the desired screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ClothesProScreen()), // Replace with your target screen
                  );
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Dismiss the dialog if an error occurs
      Navigator.of(context).pop();
      Utils().toasMessage(error.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  },
)
          ],
        ),),
      )
      );
  }
}