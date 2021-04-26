import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medhouse_project/screens/provider.dart';

class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Customers'),
          backgroundColor: Color(0xff0fb8b3),
        ),
        body: ChangeNotifierProvider<DataProvider>(
            create: (context) => DataProvider(),
            child: Consumer<DataProvider>(
                builder: (buildContext, dataProvider, _) {
              return (dataProvider.data != null)
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataProvider.data.length,
                      itemBuilder: (cxt, i) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Flexible(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        //Name
                                        dataProvider.data[i].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        //E-mail
                                        dataProvider.data[i].rating.toString(),
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : Center(child: CircularProgressIndicator());
            })));
  }
}
