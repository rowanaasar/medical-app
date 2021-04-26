import 'package:flutter/material.dart';
import 'package:medhouse_project/screens/category_screen.dart';
import 'package:medhouse_project/screens/explore_screen.dart';
import 'package:medhouse_project/screens/offers.dart';
import 'package:medhouse_project/widget/drawer.dart';
import 'package:provider/provider.dart';
import 'package:medhouse_project/model/cart.dart';
import 'package:medhouse_project/model/checkOut.dart';


class Taps extends StatefulWidget {
  @override
  _TapsState createState() => _TapsState();
}

class _TapsState extends State<Taps> {
  
  final List<Map<String, Object>> _pages = [
    {
      'page':CategoryScreen(),
      'title':'Category',
    },
    {
      'page':ExploreScreen(),
      'title':'Explore',
    },
    {
      'page': Offers(),
      'title':'Offers',
    },
    
    
  ];
  int _selectPageIndex = 0;

  void _selectPage(int value) {
    setState(() {
      _selectPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, cart, child) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CheckoutPage()));
                    },
                  ),
                  Text(cart.count.toString())
                ],
              ),
            )
          ],
          centerTitle: true,

          title: Text(_pages[_selectPageIndex]['title'],
            style: TextStyle(color: Colors.white),),
          backgroundColor:Color(0xFF0FB8B3),
        ),

        body: _pages[_selectPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Category"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("Explore"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome),
              title: Text("Offers"),
            ),
          ],
        ),
        drawer: MainDrawer(),
      );
    });
  }
}

