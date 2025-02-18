import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
class CountryController extends GetxController{
  final String getCountriesUrl = dotenv.env['getCountries']!;
  List<String> countries = [];
  List<String> cities = [];
  var dio = Dio();
  Future<void> getCountries() async {
    try {
      var response = await Dio().get(
        'http://localhost:3000/api/v1/country/getAllCountries',
      );

      if (response.statusCode == 201) {
        var countriesList = response.data['data']['countries'];
        for (var country in countriesList) {
          countries.add(country['country']);
        }
      } else {
        print("Failed to fetch countries. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  Future<void> getCities(String country) async{
    try {
      var response = await dio.request(
        "http://localhost:3000/api/v1/country/getCities?country=$country",
        options: Options(
            method: "Get"
        ),
      );
      if (response.statusCode == 200) {
        List<String> citiesList = List<String>.from(response.data['data']['cities']);
        cities.clear();
        cities.addAll(citiesList);
        update();
      }
      else {
        print(response.statusMessage);
      }
    }
    catch(e){
      print('Request failed: $e');
    }
  }

}
