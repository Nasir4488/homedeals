import 'package:dio/dio.dart' as dioo;
import 'package:get/get.dart' as gett;
import 'package:homedeals/models/property_model.dart';

class SinglePropertyController extends gett.GetxController {

  int results = 0;
  bool isLoading = false;
  Property? property;

  Future searchProperty(Map<String, dynamic>? filters) async {
    print('Filters being passed: $filters');
    dioo.Dio dio = dioo.Dio();

    // Ensure filters are not null or empty
    if (filters == null || filters.isEmpty) {
      print("Filters are null or empty");
      return null; // Return early if filters are not valid
    }

    try {
      dioo.Response response = await dio.get(
        'http://localhost:3000/api/v1/properties/filter',
        queryParameters: filters,
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      // Check if the response is valid and contains data
      if (response.statusCode == 200 && response.data != null) {
        var data = response.data['data'];
        results = response.data["results"];
        property=Property.fromJson(data);
        if (response.statusCode == 200) {
          var data = response.data['data']['properties']; // Fix this
          if (data != null && data.isNotEmpty) {
            return Property.fromJson(data[0]); // Get first property correctly
          }
        }
        
        
      } else {
        print('Error: ${response.statusMessage}');
      }
    } catch (e) {
      print("Error fetching properties: $e");
      
    } finally {
      isLoading = false;
      update(); // Ensure UI updates after the process completes
    }
    return null; // Return property or null if an error occurred
  }
}
