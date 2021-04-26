import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:medhouse_project/model/cart.dart';

class ProductDetails extends StatefulWidget {
  final String title;
  final String image;
  final String description;
  final int price;
  const ProductDetails({Key key, this.title, this.image, this.description, this.price}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, cart, child){
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: Column(
                  children: [
                    Image.network(widget.image,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                        fit: BoxFit.cover),

                    Divider(),
                    //category
                    Text(
                      'Men Care',
                      style: TextStyle(color: Colors.blue),
                    ),
                    //title
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Text(widget.title),
                    ),
                    //price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Egp ',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.price}',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    //discription

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        children: [
                          Text(
                            'Description: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ReadMoreText(
                            widget.description,
                            style: TextStyle(color: Colors.grey),
                            trimLines: 3,
                            colorClickableText: Colors.blue,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Color(0xff0fb8b3),
                              side: BorderSide(
                                  color: const Color(0xff0fb8b3),
                                  width: 1.0,
                                  style: BorderStyle.solid)),
                          onPressed: () {
                            //cart.addToCart(widget.title, widget.price);
                          },
                          child: Text('Add to Cart')),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    },);
  }
}