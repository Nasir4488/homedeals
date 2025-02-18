import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart' as gett;
import 'package:hive/hive.dart';
import 'package:homedeals/models/favorite_property.dart';
import 'package:homedeals/utils/constanats.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../models/property_model.dart';
import 'package:dio/dio.dart';

class HomeController extends gett.GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var box = Hive.box("user");

   var selectedStatus=propertyStatus[1].obs;
   var active=0.obs;
  void filterButton(int index,status) {
    active.value = index;
    selectedStatus.value = status;// Update status
    update();
  }




 bool isTokenExpired(String token){
   bool hasExpired = JwtDecoder.isExpired(token);
   return hasExpired;
 }
  Future<String?> refreshToken() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Force token refresh
        String? newToken = await user.getIdToken(true);
        await box.put('jwt', newToken); // Update token in storage
        return newToken;
      }
    } catch (e) {
      print('Failed to refresh token: $e');
    }
    return null;
  }
  Future<Options> _getOptionsWithAuth() async{
   String? token=await box.get("jwt");
   if(token==null || isTokenExpired(token)){
     token=await refreshToken();
   }
   return Options(
     headers: {
       'Content-Type': 'application/json',
       'Authorization': token != null ? 'Bearer $token' : '',
     }
   );
  }
  List<Property> properties=[];
  int results=0;
  var isfavorite=false;
  var isEye=false;
  var isCompare=false;

  favorite(){
    isfavorite=!isfavorite;
    update();
  }

  //Search Properties
  Future<List<Property>> searchProperties(Map<String,dynamic> filter) async {
    var _jwt=box.get("jwt");

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
  List<Property> favoriteProperties=[];

  //Adding to Favorite
  Future<void> addFavorite(Favorite data) async {
    Dio dio = Dio();
    var requestData = data.toJson();
    print('Request Data: ${json.encode(
        requestData)}'); // Ensure requestData is correct

    try {
      var options = await _getOptionsWithAuth();
      var response = await dio.post(
        options: options,
        'http://localhost:3000/api/v1/favorites/add',
        data: requestData,
      );

      if (response.statusCode == 200) {
        // print('Response Data: ${json.encode(response.data)}');
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Request failed with status: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
    } catch (e) {
      print('Unexpected exception: $e');
    }
  }

  //Removing form Favorite
  Future<void> removeFavorite(Favorite data) async {
    Dio dio = Dio();
    var options = await _getOptionsWithAuth();

    var requestData = data.toJson();
    print('Request Data: ${json.encode(
        requestData)}'); // Ensure requestData is correct

    try {
      var response = await dio.post(
        options: options,
        'http://localhost:3000/api/v1/favorites/remove',
        data: requestData,
      );

      if (response.statusCode == 200) {
        // print('Response Data: ${json.encode(response.data)}');
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Request failed with status: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error sending request: ${e.message}');
      }
    } catch (e) {
      print('Unexpected exception: $e');
    }
  }

  //Getting Favorite
  Future<dynamic> getFavProperties(String userId,) async {
    var _jwt=box.get("jwt");
    Dio dio = Dio();
    var options = await _getOptionsWithAuth();


    try {
      var response = await dio.get(
        options: options,
        'http://localhost:3000/api/v1/favorites/',
        queryParameters: {
          'userId': userId,
        },
      );
      var unstructuredList=response.data['data']['favorites']['favoriteProperties'];

      List<Property> properties=[];
      for(var i=0;i<unstructuredList.length;i++){
        properties.add(Property.fromJson(unstructuredList[i]));
      }

      return properties;
    } catch (e) {
      print('Error: $e');
      return []; // Return an empty list to handle the case gracefully
    }
  }

}
