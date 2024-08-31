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
  final fireStore = FirebaseFirestore.instance.collection("userspro");
  File? _image;
  final picker = ImagePicker();
  String? docId;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  // Function to load existing profile data
  Future<void> _loadProfile() async {
    QuerySnapshot querySnapshot = await fireStore.get();
    if (querySnapshot.docs.isNotEmpty) {
      var doc = querySnapshot.docs.first;
      docId = doc.id;
      var data = doc.data() as Map<String, dynamic>;
      postcontroller.text = data['title'];
      numcontroller.text = data['number'];
      setState(() {
        // Load image if available
        if (data.containsKey('imageUrl')) {
          _image = File(data['imageUrl']);
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
                      'title': postcontroller.text.toString(),
                      'number': numcontroller.text.toString(),
                      'imageUrl': imageUrl,
                      'id': id,
                    });
                    docId = id; // Update the docId so that further operations update the same profile
                  } else {
                    // Update existing profile
                    await fireStore.doc(docId).update({
                      'title': postcontroller.text.toString(),
                      'number': numcontroller.text.toString(),
                      'imageUrl': imageUrl ?? '',
                    });
                  }
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
