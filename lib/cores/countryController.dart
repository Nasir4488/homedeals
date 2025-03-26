import 'dart:convert';
import 'package:country_state_city/utils/city_utils.dart';
import 'package:country_state_city/utils/country_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
class CountryController extends GetxController{
  final String getCountriesUrl = dotenv.env['getCountries']!;
  List<String> countries = [];
  List<String> cities = [];
  List<String> flags= [];
  List<String> countryCodes = [];
  final List<String> allowedCountries = [
    "Austria", "Belgium", "Bulgaria", "Croatia", "Cyprus", "Czech Republic",
    "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary",
    "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg", "Malta", "Netherlands",
    "Poland", "Portugal", "Romania", "Slovakia", "Slovenia", "Spain", "Sweden","United Kingdom"
  ];

  var dio = Dio();
  Future<void> getCountries() async {
    try {
    var allcountries =  await getAllCountries();
    countries.clear();
    for(var country in allcountries) {
      if(allowedCountries.contains(country.name)){
        countries.add(country.name);
        flags.add(country.flag);
        countryCodes.add(country.isoCode);
        update();
      }
    }
    } catch (e) {
      print("An error occurred: $e");
    }
  }
  Future<void> getCities(String isoCode) async {
    try {
      cities.clear();
      if (isoCode != -1) {
         // Get ISO code for selected country
        var countryCities = await getCountryCities(isoCode);
        cities = countryCities.map((city) => city.name).toList();
        update();
      } }catch (e) {
      print("An error occurred while fetching cities: $e");
    }
  }
  }



