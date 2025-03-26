import 'package:dio/dio.dart';
import 'package:get/get.dart' as gett;

import '../models/property_model.dart';

class ShortFilterController extends gett.GetxController{
  List<Property> properties=[];
  bool isLoading= false;

  Future<Options> _getOptionsWithAuth() async{
    return Options(
        headers: {
          'Content-Type': 'application/json',
        }
    );
  }
  /// **Searches properties based on filters and fetches results**
  Future<List<Property>> searchProperties(Map<String, dynamic> filters) async {

    Dio dio = Dio();
    try {
      isLoading = true;
      update(); // Notify UI that loading has started

      Response response = await dio.get(
        'http://localhost:3000/api/v1/properties/filter',
        queryParameters: filters,
      );
      print("Full API Response: ${response.data}");
      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var data = response.data['data'];
        var propertiesList = data['properties'];
        if (propertiesList is List) {
          properties = propertiesList.map((item) => Property.fromJson(item)).toList();
          update(); // Update UI with new properties before returning
          return properties; // Now correctly returns the list
        }
      }

    } catch (e) {
      print("Error fetching properties: $e");
    } finally {
      isLoading = false;
      update(); // Ensure UI updates after the process completes
    }
    return []; // Return empty list if there's an error or no properties found
  }

}