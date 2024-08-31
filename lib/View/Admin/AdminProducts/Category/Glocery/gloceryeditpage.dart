import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Functions/groceryfunction.dart';
import 'package:store_app/Utils/utils.dart';
import 'package:store_app/View/SingInScreens/singin_screen.dart';

class GloceryProScreen extends StatefulWidget {
  const GloceryProScreen({super.key});

  @override
  State<GloceryProScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<GloceryProScreen> {
  final auth = FirebaseAuth.instance;
  final editTitleController = TextEditingController();
  final editPriceController = TextEditingController();
  final editDiscountController = TextEditingController();
  final editDescriptionController = TextEditingController();
  final FirebaseServiceGlocery firebaseService = FirebaseServiceGlocery(); // Create an instance of FirebaseService
  bool isLoading = false;

  void _logout() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print('Error logging out: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  File? image;

  final fireStore = FirebaseFirestore.instance.collection("glocerydata").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Glocery Edit", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: Icon(Icons.logout, color: Colors.white),
          )
        ],
        backgroundColor: AppColors.primaryVariant,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No data available"));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    var data = doc.data() as Map<String, dynamic>;
                    String? imageUrl = data['imageUrl'];
                    return Card(
                      color: Colors.blue.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 50,
                                backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
                                child: imageUrl == null ? Icon(Icons.person, size: 50) : null,
                              ),
                              title: Text(data['title'].toString(), style: TextStyle(fontSize: 20),),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.black),
                                    onPressed: () => showMyDialog(
                                      title: data['title'].toString(),
                                      id: doc.id.toString(),
                                      imageUrl: imageUrl,
                                      price: data['price'],
                                      discount: data['disprice'],
                                      description: data['description'],
                                    ),
                                  ),
                                 IconButton(
  icon: Icon(Icons.delete, color: Colors.red),
  onPressed: () async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: CircularProgressIndicator()),
          content: Text("Deleting..."),
            
        );
      },
    );

    try {
      // Perform the delete operation
      await firebaseService.deleteDocument(doc.id.toString(), imageUrl);

      // Dismiss the progress dialog
      Navigator.of(context).pop();

      // Show a success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Delete Successful"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the success dialog
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Dismiss the progress dialog if an error occurs
      Navigator.of(context).pop();
      Utils().toasMessage('Failed to delete document: $error');
    }
  },
),
                                ],
                              ),
                            ),
                            Gutter(),
                            Divider(thickness: 5,color: Colors.black,),
                            Gutter(),
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Text('Price: ${data['price']}', style: TextStyle(fontSize: 20),),
                              Text('Discount Price: ${data['disprice']}', style: TextStyle(fontSize: 20),),
                              Text('Description: ${data['description']}', style: TextStyle(fontSize: 20),),
                              ],
                             )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showMyDialog({
    required String title,
    required String id,
    required String? imageUrl,
    required String price,
    required String discount,
    required String description,
  }) async {
    editTitleController.text = title;
    editPriceController.text = price;
    editDiscountController.text = discount;
    editDescriptionController.text = description;
    File? _newImage;

    Future pickNewImage() async {
      _newImage = await firebaseService.pickImageFromGallery();
      setState(() {});
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _newImage != null
                      ? FileImage(_newImage!) as ImageProvider
                      : imageUrl != null
                          ? NetworkImage(imageUrl)
                          : null,
                  child: _newImage == null && imageUrl == null
                      ? Text("No Image", style: TextStyle(fontSize: 12, color: Colors.black))
                      : null,
                ),
                SizedBox(height: 10),
                TextButton(onPressed: pickNewImage, child: Text("Change Image")),
                TextField(
                  controller: editTitleController,
                  decoration: InputDecoration(hintText: "Title"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: editPriceController,
                  decoration: InputDecoration(hintText: "Price"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: editDiscountController,
                  decoration: InputDecoration(hintText: "Discount Price"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: editDescriptionController,
                  decoration: InputDecoration(hintText: "Description"),
                  maxLines: 3,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                try {
                  if (_newImage != null) {
                    if (imageUrl != null) {
                      await firebaseService.deleteImageFromStorage(imageUrl);
                    }
                    String newImageUrl = await firebaseService.uploadImage(_newImage!);
                    await firebaseService.updateDocument(
                      id,
                      editTitleController.text,
                      newImageUrl,
                      editPriceController.text,
                      editDiscountController.text,
                      editDescriptionController.text,
                    );
                  } else {
                    await firebaseService.updateDocument(
                      id,
                      editTitleController.text,
                      imageUrl,
                      editPriceController.text,
                      editDiscountController.text,
                      editDescriptionController.text,
                    );
                  }
                } catch (e) {
                  Utils().toasMessage('Failed to update document: $e');
                }
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
