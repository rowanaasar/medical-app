import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medhouse_project/model/cart.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List cartItems =[];
  List cartPrices =[];
  double sum = 0;
  User user = FirebaseAuth.instance.currentUser;

  getData() async{
    DocumentReference cartRef = FirebaseFirestore.instance.collection("cart").doc(user.uid);
    var response = await cartRef.get();
      setState(() {
        cartItems = response.data()['items'];
        cartPrices = response.data()['prices'];
        sum = response.data()['total price'];
      });
    //print(userProfileImage);
  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Checkout Page [ total of \$ $sum ]'),
            ),
            body: cartItems.length == 0
                ? Text('no items in your cart')
                : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(cartItems[index]),
                    subtitle:
                    Text(cartPrices[index].toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        cart.remove(cartItems[index], cartPrices[index]);
                        getData();
                      },
                    ),
                  ),
                );
              },
            ));
      },
    );
  }
}