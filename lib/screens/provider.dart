import 'package:flutter/material.dart';
import 'package:medhouse_project/model/category_model.dart';
import 'package:medhouse_project/reposatory/reposatory.dart';


class DataProvider extends ChangeNotifier{
List<Data> data;
  DataRepository _movieRepository = DataRepository();

  DataProvider(){
    getData();
  }
  void getData() {
    _movieRepository.fetchData().then(
            (newdata){
          data = newdata;
          notifyListeners();
        }
    );
  }
}