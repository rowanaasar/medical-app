import 'package:flutter/material.dart';
import 'package:medhouse_project/screens/category_detailes.dart';

class CategoryItem extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final String rating;
  final String category;

  CategoryItem({Key key, this.id, this.title, this.image, this.rating, this.category});

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  void selectCategory(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => CategoryDetailes(title:widget.title)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: InkWell(
        onTap: () => selectCategory(context),
         child:
         Card(
             child: Column(
               children: [
                 Image.network(widget.image,
                     width: MediaQuery.of(context).size.width/3,
                     height:
                     MediaQuery.of(context).size.height / 8,
                     fit: BoxFit.cover),
                 Text(widget.title)
               ],

             )),

      ),
    );
  }
}
