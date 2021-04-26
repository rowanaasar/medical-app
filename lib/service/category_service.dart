import 'dart:convert';
import 'package:medhouse_project/model/category_model.dart';
import 'package:http/http.dart' as http;

class DataService {

  Future<List<Data>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://api.androidhive.info/json/movies.json'));
    if (response.statusCode == 200) {
      //print(response.body);
      var mappedResponse = json.decode(response.body) as List;
      List<Data> data = mappedResponse.map((postResponse) => Data.fromJson(postResponse)).toList();
      return data;
    } else {
      throw Exception('FAILED TO LOAD data');
    }
  }
 }
