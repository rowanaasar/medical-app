import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:medhouse_project/screens/product_details.dart';
// import 'file:///F:/Flutter/medhouse_project/lib/screens/product_details.dart';
import 'package:provider/provider.dart';
import 'package:medhouse_project/model/cart.dart';


class ViewAllOffers extends StatefulWidget {
  @override
  _ViewAllOffersState createState() => _ViewAllOffersState();
}

class _ViewAllOffersState extends State<ViewAllOffers> {



  List posts = [];
  List ids = [];
  CollectionReference postsRef = FirebaseFirestore.instance.collection("post");

  getData() async {
    var response = await postsRef.get();
    response.docs.forEach((element) {
      setState(() {
        posts.add(element.data());
        ids.add(element.id);
      });
      print(posts);
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
            title: Text('MedHouse Offers'),
          ),
          body: Padding(
              padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    'Offers',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        decoration: TextDecoration.underline),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: posts.length,
                      itemBuilder: (cxt, i) {
                        final data = posts[i];
                        return GestureDetector(
                          onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                          title: data['title'],
                                          image: data['image'],
                                        )),
                              );
                            },
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.network(data['image'],
                                        width: MediaQuery.of(context)
                                            .size
                                            .width /
                                            3,
                                        height: MediaQuery.of(context)
                                            .size
                                            .height /
                                            8,
                                        fit: BoxFit.cover),
                                    Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(posts[i]['title']),
                                              Text(
                                                'EGP' + '3.50',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors.white,
                                                          onPrimary:
                                                              Color(0xff0fb8b3),
                                                          side: BorderSide(
                                                              color: const Color(
                                                                  0xff0fb8b3),
                                                              width: 1.0,
                                                              style: BorderStyle
                                                                  .solid)),
                                                  onPressed: () {
                                                    cart.addToCart(
                                                        data['title'],
                                                        data['price']);
                                                  },
                                                  child: Text('Add to Cart'))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: FavoriteButton(
                                          iconSize: 40,
                                          isFavorite: false,
                                          valueChanged: () {},
                                        ),
                                    ),
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          )

      );
    },
    );
  }
}
