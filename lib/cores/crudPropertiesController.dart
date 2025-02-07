import 'package:dio/dio.dart';
import 'package:get/get.dart' as gett;

import '../models/property_model.dart';
class Crudpropertiescontroller extends gett.GetxController{
  List<Property> properties=[];
  //Get Propertiies

  Future<List<Property>> searchProperties(Map<String,dynamic> filter,id) async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        'http://localhost:3000/api/v1/properties/filter',
        queryParameters: filter,
      );
      if (response.statusCode == 200) {
        var data = response.data['data'];
          var results = response.data["results"];
          print(results);
        var propertiesList = data['properties'];
        if (propertiesList is List) {
          var cureentPropert = id;
          properties=[];
          for (var item in propertiesList) {
            Property releatedProperties = Property.fromJson(item);
            if (releatedProperties.id != cureentPropert) {
              properties.add(Property.fromJson(item));
            }
          }
          update();
          print(properties.length);
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