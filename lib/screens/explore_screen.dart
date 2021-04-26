    import 'package:flutter/material.dart';
import 'package:medhouse_project/screens/provider.dart';
import 'package:medhouse_project/widget/button.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final String rating;

  ExploreScreen({Key key, this.id, this.title, this.image, this.rating});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(),
      body: ChangeNotifierProvider<DataProvider>(
        create: (context) => DataProvider(),
        child: Consumer<DataProvider>(
          builder: (buildContext, dataProvider, _) {
            return (dataProvider.data != null)
                ? Container(
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          color: Color(0xFF0FB8B3),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            obscureText: false,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'What you are looking for',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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

// import 'package:flutter/material.dart';
// import 'package:medhouse/screen/provider.dart';
// import 'package:medhouse/widget/button.dart';
// import 'package:provider/provider.dart';

// class ExploreScreen extends StatefulWidget {
//   final String id;
//   final String title;
//   final String image;
//   final String rating;

//   ExploreScreen({Key key, this.id, this.title, this.image, this.rating});

//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<ExploreScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // appBar: AppBar(),
//       body: ChangeNotifierProvider<DataProvider>(
//         create: (context) => DataProvider(),
//         child: Consumer<DataProvider>(
//           builder: (buildContext, dataProvider, _) {
//             return (dataProvider.data != null)
//                 ?     ListView.builder(
//                           itemCount: dataProvider.data.length,
//                           itemBuilder: (context, index) {
//                             return Card(
//                               child: Container(
//                                 padding: EdgeInsets.all(10),
//                                 //color: Color(0xFF0FB8B3),
//                                 width: 200,
//                                 height: 210,
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Image(
//                                       image: NetworkImage(
//                                           dataProvider.data[index].image),
//                                       width: 200,
//                                       height: 70,
//                                     ),
//                                      ListTile(
//                                       title: Text(dataProvider.data[index].title),
//                                       subtitle: Text('50 EG'),
//                                     ),
//                                     Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: <Widget>[
//                                           RaisedButton(
//                                               child: Text('ADD'),
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                 Radius.circular(7.0),
//                                               )),
//                                               onPressed: () {})
//                                         ])
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                        )
//                   //     ],
//                   //   ),
//                   // )
//                 : Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
// } 