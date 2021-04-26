import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medhouse_project/screens/product_details.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:provider/provider.dart';
import 'package:medhouse_project/model/cart.dart';

class CategoryDetailes extends StatefulWidget {
  final String title;
  const CategoryDetailes({Key key, this.title}) : super(key: key);
  @override
  _CategoryDetailesState createState() => _CategoryDetailesState();
}

class _CategoryDetailesState extends State<CategoryDetailes> {
  List posts = [];
  CollectionReference postsRef = FirebaseFirestore.instance.collection("post");

  getData() async{
    var response = await postsRef.where('category',isEqualTo: widget.title).get();
    response.docs.forEach((element) {
      setState(() {
        posts.add(element.data());
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
    return Consumer<Cart>(builder: (context, cart, child){
      return Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context,i){
            //Text("${posts[i]['title']}")
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetails(
                          title: posts[i]['title'],
                          image: posts[i]['image'],
                          description: posts[i]['body'],
                          price: posts[i]['price'],
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
                          Image.network(posts[i]['image'],
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
                              padding: const EdgeInsets.only(
                                  left: 8.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(posts[i]['title']),
                                  Text(
                                    'EGP ${posts[i]['price']}',
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                          Colors.white,
                                          onPrimary: Color(
                                              0xff0fb8b3),
                                          side: BorderSide(
                                              color: const Color(
                                                  0xff0fb8b3),
                                              width: 1.0,
                                              style:
                                              BorderStyle
                                                  .solid)),
                                      onPressed: () {
                                        cart.addToCart(posts[i]['title'], posts[i]['price']);
                                      },
                                      child:
                                      Text('Add to Cart'))
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0),
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
              ),
            );
          },
        ),
      );
    },);

  }
}