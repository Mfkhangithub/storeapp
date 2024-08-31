import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/Utils/utils.dart';

class FirebaseServiceShoes {
  final picker = ImagePicker();
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('shoesdata');

  Future<File?> pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      Utils().toasMessage("No image selected");
      return null;
    }
  }

  Future<File?> pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      Utils().toasMessage("No image selected");
      return null;
    }
  }

  Future<String> uploadImage(File image) async {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('post_images')
        .child(id);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<void> updateDocument(String id, String newTitle, String? newImageUrl,String newPrice, String newDiscountPrice, String newDescription,) async {
    try {
      await usersCollection.doc(id).update({
        'title': newTitle,
        'imageUrl': newImageUrl,
        'price': newPrice,
        'disprice': newDiscountPrice,
        'description': newDescription,
      });
      Utils().toasMessage('Document Updated');
    } catch (error) {
      Utils().toasMessage('Failed to update document: $error');
    }
  }

  Future<void> deleteDocument(String id, String? imageUrl) async {
    try {
      await usersCollection.doc(id).delete();
      if (imageUrl != null && imageUrl.isNotEmpty) {
        await deleteImageFromStorage(imageUrl);
      }
      Utils().toasMessage('Document and Image Deleted');
    } catch (error) {
      Utils().toasMessage('Failed to delete document: $error');
    }
  }

  Future<void> deleteImageFromStorage(String imageUrl) async {
    try {
      if (imageUrl.isNotEmpty) {
        Reference ref = FirebaseStorage.instance.refFromURL(imageUrl);
        await ref.delete();
      }
    } catch (error) {
      Utils().toasMessage('Failed to delete image: $error');
    }
  }
}
