import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
class CountryController extends GetxController{
  final String getCountriesUrl = dotenv.env['getCountries']!;
  List<String> countries = [];
  var dio = Dio();
  Future<void> getCountries() async {
    try {
      var response = await Dio().get(
        'http://localhost:3000/api/v1/country/getAllCountries',
      );

      if (response.statusCode == 201) {
        // Extract countries from response
        var countriesList = response.data['data']['countries'];

        for (var country in countriesList) {
          countries.add(country['country']);
        }

        // Print the list of countries
        print(countries);
      } else {
        print("Failed to fetch countries. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

}
