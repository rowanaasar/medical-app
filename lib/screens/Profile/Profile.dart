import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medhouse_project/screens/Profile/create_post.dart';
import 'package:provider/provider.dart';
import 'package:medhouse_project/screens/provider.dart';
import 'package:maps_launcher/maps_launcher.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PickedFile imageFile;
  File file;
  var currentUser,imageName,refStorage;
  var user = FirebaseAuth.instance.currentUser;
  var userProfileImage, latitude, longitude, name, address, specialism, type;
  List posts = [];
  List nearProviders = [];

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
      uploadImage(imageFile);
    });

    Navigator.pop(context);
  }

  void openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
      uploadImage(imageFile);
    });
    Navigator.pop(context);
  }

  uploadImage(image) async{
    file = File(imageFile.path);
    //imageName = basename(image.path);
    refStorage = FirebaseStorage.instance.ref('images/${user.uid}');
    CollectionReference userRef =  FirebaseFirestore.instance.collection('users');
    await refStorage.putFile(file);
    var downloadURL = await refStorage.getDownloadURL();
    //print('url: $downloadURL');
    userRef.doc(user.uid).set({"image":downloadURL},SetOptions(merge: true))
        .then((value) => print('Update success ---------------------------------------'))
        .catchError((e)=>print("Error : ---- $e"));
  }
  getData()async{
    //to get profile data
    DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(user.uid);
    //to get business accounts nearby

    CollectionReference postsRef = FirebaseFirestore.instance.collection("post");
    var userdata = await userRef.get();
    userProfileImage =  userdata['image'];
    longitude = userdata['longitude'];
    latitude = userdata['latitude'];
    name = userdata['userName'];
    address = userdata['location'];
    specialism = userdata['specialization'];
    type = userdata['type'];

    var respose = await postsRef.where('author',isEqualTo:user.uid).get();
    respose.docs.forEach((element) {
      setState(() {
        posts.add(element.data());
      });
      //print(posts);
    });
    print(userProfileImage);
  }
  getUsers()async{
    CollectionReference providerRef = FirebaseFirestore.instance.collection('users');
    var response = await providerRef.where('type',isEqualTo: 'business').get();
    response.docs.forEach((element) {
      setState(() {
        nearProviders.add(element.data());
      });
      print(nearProviders);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
    getUsers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Color(0xff0fb8b3),
        ),
        body:
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flexible(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                (imageFile == null)
                                    ? ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(
                                      50),
                                  child: Image(
                                    image: NetworkImage (
                                        (userProfileImage==null)?
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvb-EdcyOYIYcdeu_ko7o8_RaUDA38aaaNjfSup0JxH24z9llG&s'
                                            :userProfileImage
                                    ),
                                    width: 100,
                                    height: 100,
                                  ),
                                )
                                    : ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(
                                      50),
                                  child: Image.file(
                                    File(imageFile.path),
                                    cacheHeight: 100,
                                    cacheWidth: 100,
                                  ),
                                ),
                                Positioned(
                                  right: 65,
                                  bottom: 13,
                                  child: IconButton(
                                    icon: Icon(Icons.camera_alt),
                                    color: Color(0xff0fb8b3),
                                    onPressed: () {
                                      showChoiceDialog(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('+9'),
                            Icon(Icons.message_outlined,
                                color: Color(0xff0fb8b3)),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25, bottom: 25),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Name: ',
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  Text(name),
                                ],
                              ),
                              Row(
                                children: [
                                  Wrap(
                                      children:[ Text('Location: ',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                      ]),
                                  Text(address),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Spicialist: ',
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold)),
                                  Text(specialism)
                                ],
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                    (type == 'business')?
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30, bottom: 30),
                      child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Last Postes",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            FloatingActionButton(
                              backgroundColor: Colors.indigo[700],
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreatePost()),
                                );
                              },
                              child: Center(
                                  child: Text('+',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ))),
                            ),
                          ]),
                    )
                        :
                    SizedBox(height: 50)
                    ,
                    (type == 'business')?
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: posts.length,
                        itemBuilder: (cxt, i) {
                          return Column(
                            children: [
                              Card(
                                child: Column(
                                  children: [
                                    Text(posts[i]['body']),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: Image.network(
                                          '${posts[i]["image"]}',
                                          width:
                                          MediaQuery.of(context)
                                              .size
                                              .width /
                                              2,
                                          fit: BoxFit.cover),
                                    ),
                                    //icons
                                    Container(
                                      color: Color(0xff0fb8b3),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(
                                            2.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  left: 18,
                                                  right: 22),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .favorite,
                                                      color: Colors
                                                          .white),
                                                  Text('207',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .white))
                                                ],
                                              ),
                                            ),

                                            Row(
                                              children: [
                                                Icon(Icons.comment,
                                                    color: Colors
                                                        .white),
                                                Text(
                                                  '97',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .white),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        })
                        :
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: nearProviders.length,
                        itemBuilder: (cxt, i) {
                          return Column(
                            children: [
                              Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(child: Text(nearProviders[i]['userName'],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)),
                                    Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:[
                                              Text('Location: '),
                                              Expanded(child: Text(nearProviders[i]["location"]))]
                                        )

                                    ),
                                    Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children:[
                                                    Text('Specialist: '),
                                                    Text(nearProviders[i]["specialization"]),

                                                  ]),
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Colors.indigo[500],
                                                    onPrimary: Colors.white,
                                                  ),
                                                  child: Text('Google Map'),
                                                  onPressed: () {
                                                    MapsLauncher.launchCoordinates(
                                                        nearProviders[i]["latitude"],
                                                        nearProviders[i]["longitude"],
                                                        'Google Headquarters are here');
                                                  })
                                            ],
                                          ),
                                        )

                                    ),
                                  ],

                                ),
                              ),
                              Divider(),
                            ],
                          );
                        })
                    ,
                  ],
                ),
              ),
            ),
          ),
        )
    );}
  }

