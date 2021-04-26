import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './Profile.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController title = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController body = new TextEditingController();
  String categoryValue = 'Women Care';
  User user = FirebaseAuth.instance.currentUser;
  var postID = Random().nextInt(99999999);
  PickedFile imageFile;
  File file;
  var refStorage;

  Future showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile;
    });

    Navigator.pop(context);
  }

  void openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Post'),
          backgroundColor: Color(0xff0fb8b3),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 25),
                  child: Text(
                    'Create Post',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  controller: title,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Add title",
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: price,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Add price",
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  controller: body,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Add Description",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff0fb8b3),
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        showChoiceDialog(context);
                      },
                      icon: Icon(Icons.add_a_photo),
                      label: Text('Upload Photo')),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (imageFile == null)
                        ? Row()
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(
                        File(imageFile.path),
                        cacheHeight: 150,
                        cacheWidth: 150,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text(
                        'Choose Category: ',
                      ),
                    ),
                    DropdownButton<String>(
                      dropdownColor: Colors.grey[100],
                      value: categoryValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 15,
                      elevation: 10,
                      underline: Container(
                        height: 2,
                        color: Color(0xff0fb8b3),
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          categoryValue = newValue;
                        });
                      },
                      items: <String>[
                        'Women Care',
                        'Hair Care',
                        'Beauty',
                        'Bath&Body',
                        'Men Care',
                        'Baby',
                        'Personal Care',
                        'Contact Lenses'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.indigo[700],
                            onPrimary: Colors.white,
                          ),
                          onPressed: () {
                            addPost(title.text, int.parse('${price.text}') ,body.text, '${user.uid}$postID',
                                categoryValue);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()),
                            );
                          },
                          child: Text('Post'))),
                )
              ],
            ),
          ),
        ));
  }

  addPost(title, price ,body, image, category) async {
    file = File(imageFile.path);
    CollectionReference postRef = FirebaseFirestore.instance.collection('post');
    refStorage = FirebaseStorage.instance.ref('images/${user.uid}$postID');
    await refStorage.putFile(file);
    var downloadURL = await refStorage.getDownloadURL();
    print('url: $downloadURL');
    return postRef
        .doc('$postID')
        .set({
      'author': user.uid, // John Doe
      'title': title, // Stokes and Sons
      'price': price,
      'body': body,
      'image': downloadURL,
      'category': category,
    })
        .then((value) => print("Post Added"))
        .catchError((error) => print("Failed to add post: $error"));
  }
}