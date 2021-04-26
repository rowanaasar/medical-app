
import 'package:medhouse_project/model/category_model.dart';
import 'package:medhouse_project/service/category_service.dart';

class DataRepository{
  DataService _dataService = DataService();

  Future<List<Data>> fetchData(){
    return _dataService.fetchData();
  }
}