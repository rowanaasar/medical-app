import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medhouse_project/screens/product_details.dart';
// import 'file:///F:/Flutter/medhouse_project/lib/screens/product_details.dart';
import 'package:medhouse_project/screens/provider.dart';
import 'package:medhouse_project/screens/slider.dart';
// import 'file:///F:/Flutter/medhouse_project/lib/screens/slider.dart';
import 'package:provider/provider.dart';
import 'package:medhouse_project/model/category_model.dart';
import 'viewall_offers.dart';

class Offers extends StatefulWidget {
  final Data data;

  const Offers({Key key, this.data}) : super(key: key);

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  List posts = [];
  CollectionReference postsRef = FirebaseFirestore.instance.collection("post");

  getData() async {
    var response = await postsRef.get();
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
    return Scaffold(

      body: ChangeNotifierProvider<DataProvider>(
        create: (context) => DataProvider(),
        child: Consumer<DataProvider>(
          builder: (buildContext, dataProvider, _) {
            return (dataProvider.data != null)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Center(
                            child: SliderWidget(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "MedHouse Choices",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Color(0xff0fb8b3),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewAllOffers()),
                                  );
                                },
                                child: Text(
                                  'View All',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 8,
                          child: Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: dataProvider.data.length - 7,
                              itemBuilder: (BuildContext context, int i) =>
                                  GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetails(
                                              title: posts[i]['title'],
                                              image: posts[i]['image'],
                                            )),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Center(
                                    child: Image.network(
                                        '${posts[i]['image']}',
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, bottom: 20),
                          child: Text(
                            'Todays offers',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
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
                                                title: posts[i]['title'],
                                                image: posts[i]['image'],
                                              )),
                                    );
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(2.0)),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Image.network(
                                                  data['image'],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.1,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      6,
                                                  fit: BoxFit.cover),
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
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
