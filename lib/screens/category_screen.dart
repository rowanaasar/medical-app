import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medhouse_project/screens/product_details.dart';
import 'package:medhouse_project/widget/category_item.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key key}) : super(key: key);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CollectionReference postsRef =
  FirebaseFirestore.instance.collection('categories');
  List firebasePosts = [];
  getData() async {
    var response = await postsRef.get();
    response.docs.forEach((element) {
      setState(() {
        firebasePosts.add(element.data());
      });
      print(element.data());
    });
    print('----------------------*------');
    print(firebasePosts);
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Shop by Category',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          Expanded(
            child: GridView(
              children: firebasePosts
                  .map((catDate) => CategoryItem(
                title: catDate['title'],
                image: catDate['image'],
              ))
                  .toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
              ),
            ),
          ),
        ]));
  }
}