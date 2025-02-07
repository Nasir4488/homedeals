import 'package:dio/dio.dart';
import 'package:get/get.dart' as gett;

import '../models/property_model.dart';

class ShortFilterController extends gett.GetxController{
  List<Property> properties=[];
  Future<Options> _getOptionsWithAuth() async{
    return Options(
        headers: {
          'Content-Type': 'application/json',
        }
    );
  }

  Future<List<Property>> searchProperties(Map<String,dynamic> filter) async {

    Dio dio = Dio();

    try {
      var options = await _getOptionsWithAuth();
      Response response = await dio.get(
        options: options,
        'http://localhost:3000/api/v1/properties/filter',
        queryParameters: filter,

      );
      if (response.statusCode == 200) {
        var data = response.data['data'];
        var results = response.data["results"];
        var propertiesList = data['properties'];
        if (propertiesList is List) {
          properties=[];
          for (var item in propertiesList) {
            Property releatedProperties = Property.fromJson(item);
            properties.add(Property.fromJson(item));
          }
          results=properties.length;
          update();
          return properties;
        }
      }
    } catch (e) {
      print("Error: $e");
    }
    // Return an empty list in case of an error or no properties found
    return [];
  }
}