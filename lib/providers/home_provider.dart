import 'package:beehive/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeProvider with ChangeNotifier {
  List<HomeModel>? mainCategories;

  Future<void> getMainCategories() async {
    var response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );
    if (response.statusCode == 200) {
      print('Main Categories Api is working perfectly.');
      mainCategories = homeModelFromJson(response.body);
    } else {
      print('Main Categories Api is not working correctly');
    }
    print(response.body);
    notifyListeners();
  }
}
