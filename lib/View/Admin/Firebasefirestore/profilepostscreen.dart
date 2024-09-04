import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Utils/utils.dart';
import 'package:store_app/Utils/widget/roundbutoon.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreProfilePostscreen extends StatefulWidget {
  const FirestoreProfilePostscreen({super.key});

  @override
  State<FirestoreProfilePostscreen> createState() => _FirestorePostscreenState();
}

class _FirestorePostscreenState extends State<FirestoreProfilePostscreen> {
  final postcontroller = TextEditingController();
  final numcontroller = TextEditingController();
  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection("users");
  File? _image;
  final picker = ImagePicker();
  String? docId;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the widget tree
    postcontroller.dispose();
    numcontroller.dispose();
    super.dispose();
  }

  // Function to load existing profile data
  Future<void> _loadProfile() async {
    QuerySnapshot querySnapshot = await fireStore.get();
    if (querySnapshot.docs.isNotEmpty) {
      var doc = querySnapshot.docs.first;
      docId = doc.id;
      var data = doc.data() as Map<String, dynamic>;
      postcontroller.text = data['username'];
      numcontroller.text = data['phone'];
      setState(() {
        // Load image if available
        if (data.containsKey('imageUrl')) {
          // Load the image from the URL and display it
          _image = null; // Reset _image if you are not caching it locally
        }
      });
    }
  }

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
    Reference ref = FirebaseStorage.instance.ref().child('postpro_images').child(id);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryVariant,
        title: Text(
          "Profile Post Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
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
            Gutter(),

            TextFormField(
              maxLines: 1,
              controller: postcontroller,
              decoration: InputDecoration(
                hintText: "Enter your name",
                border: OutlineInputBorder(),
              ),
            ),
            Gutter(),
            TextFormField(
              maxLines: 1,
              controller: numcontroller,
              decoration: InputDecoration(
                hintText: "Enter your phone no",
                border: OutlineInputBorder(),
              ),
            ),
            Gutter(),
            RoundButton(
              loading: loading,
              title: docId == null ? "Create Profile" : "Update Profile",
              onTap: () async {
                setState(() {
                  loading = true;
                });
                try {
                  String? imageUrl;
                  if (_image != null) {
                    imageUrl = await uploadImage(_image!);
                  }

                  if (docId == null) {
                    // Create new profile
                    String id = DateTime.now().microsecondsSinceEpoch.toString();
                    await fireStore.doc(id).set({
                      'username': postcontroller.text.toString(),
                      'phone': numcontroller.text.toString(),
                      'imageUrl': imageUrl,
                      'id': id,
                    });
                    docId = id; // Update the docId so that further operations update the same profile
                  } else {
                    // Update existing profile
                    await fireStore.doc(docId).update({
                      'username': postcontroller.text.toString(),
                      'phone': numcontroller.text.toString(),
                      'imageUrl': imageUrl ?? '',
                    });
                  }
                  postcontroller.clear();
                  numcontroller.clear();
                  _image = null; // Clear the selected image
                  Utils().toasMessage("Profile Saved");
                } catch (error) {
                  Utils().toasMessage(error.toString());
                } finally {
                  setState(() {
                    loading = false;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
