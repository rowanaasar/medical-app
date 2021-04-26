import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medhouse_project/model/item.dart';

class Cart extends ChangeNotifier {
  List<Item> _items = [];
  double _totalPrice = 0.0;

  List cartItems =[];
  List cartPrices =[];
  double sum = 0;
  User user = FirebaseAuth.instance.currentUser;
  CollectionReference cartRef = FirebaseFirestore.instance.collection('cart');
  addToCart(title, price ) async {
    cartItems.add(title);
    cartPrices.add(price);
    sum = sum + price;
    return cartRef
        .doc(user.uid)
        .set({
      'items': cartItems, // John Doe
      'prices': cartPrices, // Stokes and Sons
      'total price': sum,
    })
        .then((value) => print("Post Added"))
        .catchError((error) => print("Failed to add post: $error"));
  }


  void remove(title,price) async{
    sum -= price;
    cartItems.remove(title);
    cartPrices.remove(price);
    return cartRef
        .doc(user.uid)
        .set({
      'items': cartItems, // John Doe
      'prices': cartPrices, // Stokes and Sons
      'total price': sum,
    })
        .then((value) => print("Post deleted"))
        .catchError((error) => print("Failed to add post: $error"));
  }

  int get count {
    return _items.length;
  }

  double get totalPrice {
    return _totalPrice;
  }

  List<Item> get basketItems {
    return _items;
  }
}