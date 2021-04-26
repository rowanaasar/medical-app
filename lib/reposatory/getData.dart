import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  Auth({Key key}) : super(key: key);
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  UserCredential userCredential;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Auth'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: ElevatedButton(
                  onPressed: () async {
                    //getUser('NFj6BvJ6pGXxiubQGZVk');
                    //addUser('mmmmm@en.com', 'image', 'mmmmmmmm');
                  },
                  child: Text("Get User"),
                )),

          ],
        ));
  }
  CollectionReference userRef= FirebaseFirestore.instance.collection('users');
  getUser(id) async{
    DocumentReference user= userRef.doc(id);
    await user.get().then((value) {
      print(value.data());
      print('//////////////////////');
    });
  }
  addUser(email,image,userName){
    return userRef
        .add({
      'email': email, // John Doe
      'image': image, // Stokes and Sons
      'userName': userName // 42
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

  }
  File file;
  var imagePicker = ImagePicker();
  uploadrImage(){
    var imagePicked = imagePicker.getImage(source: ImageSource.gallery);
  }
  getImage(){
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
  }

}






