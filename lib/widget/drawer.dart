import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medhouse_project/screens/Consultation_screen.dart';
import 'package:medhouse_project/screens/Profile/Profile.dart';
import 'package:medhouse_project/screens/Vouchers_screen.dart';
import 'package:medhouse_project/screens/explore_screen.dart';
import 'package:medhouse_project/screens/favourite_item.dart';
import 'package:medhouse_project/screens/help_screen.dart';
import 'package:medhouse_project/screens/notification_screen.dart';
import 'package:medhouse_project/screens/taps_screen.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String fullName;
  var user = FirebaseAuth.instance.currentUser;
  var userProfileImage;
  getData()async{
    DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(user.uid);
    CollectionReference postsRef = FirebaseFirestore.instance.collection("post");
    var userdata = await userRef.get();
    userProfileImage =  userdata['image'];
    print(userProfileImage);
  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
  }
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
        color: Color(0xFF0FB8B3),
      ),
      title: Text(
        title,
        style: TextStyle(
            // fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    // String userName;
    //i define userName here to conver the erroe whitch occer when i but var in top ..variable must be final in stf ?? and we need

    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Color(0xFF0FB8B3),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(
                height: 40.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'MedHouse',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                CloseButton(
                  color: Colors.white,
                ),
              ]),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: (){Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Profile()));},
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  // ClipRRect(
                  //   borderRadius:
                  //   BorderRadius.circular(
                  //       50),
                  //   child: Image(
                  //     image: NetworkImage (
                  //         (userProfileImage != null)?
                  //         userProfileImage
                  //             :'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvb-EdcyOYIYcdeu_ko7o8_RaUDA38aaaNjfSup0JxH24z9llG&s'
                  //     ),
                  //     width: 50,
                  //     height: 50,
                  //   ),
                  // ),
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                  Text(
                      user.email,
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),

                  // Text(userName),
                ]),
              )
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Home', Icons.home, () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Taps()));
          }),
          buildListTile('Explore', Icons.search, () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ExploreScreen()));
          }),
          buildListTile('Notification', Icons.notification_important, () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NotificationScreen()));
          }),
          buildListTile('favourite Item', Icons.star, () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FavouriteScreen()));
          }),
          buildListTile('My Vouchers', Icons.card_giftcard, () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => VouchersScreen()));
          }),
          buildListTile('Consultation', Icons.admin_panel_settings_outlined,
              () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ConsultationScreen()));
          }),
          buildListTile('Help Center', Icons.help_center, () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HelpScreen()));
          }),
        ],
      ),
    );
  }
}
