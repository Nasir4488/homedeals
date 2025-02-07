import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
class ProfileController extends GetxController{
  FirebaseAuth auth=FirebaseAuth.instance;
  var phoneController=TextEditingController();
  var faxController=TextEditingController();
  var mobileController=TextEditingController();
  var taxController=TextEditingController();
  var addressController=TextEditingController();
  var officeController=TextEditingController();
  var descriptionController = TextEditingController();




  Future<void> postProfile(Map<String, dynamic> profile) async {
    var url="http://localhost:3000/api/v1/profile/add";
    var box = Hive.box("user");
    var _jwt=box.get('jwt');
    var headers = {
      'Authorization': 'Bearer $_jwt',
      'Content-Type': 'application/json',
      // 'Cookie': 'jwt=$_jwt'
    };

    var dio = Dio();
    var response = await dio.request(
      url,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: profile,
    );
    if (response.statusCode == 200) {
      // print(json.encode(response.data));
    }
    else {
      print(response.statusMessage);
    }
  }

  Future<void> patchProfile(Map<String,dynamic> profile)async{

    var box = Hive.box("user");
    var _jwt=box.get('jwt');

    var _url='http://localhost:3000/api/v1/profile/update';

    var headers = {
      'Authorization': 'Bearer $_jwt',
      'Content-Type': 'application/json',
    };
    var data = profile;
    var dio = Dio();
    var response = await dio.request(
      _url,
      options: Options(
        method: 'PATCH',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    }
    else {
      print(response.statusMessage);
    }
  }
  Future<Map<String, dynamic>?> getCurrentUserProfile(String userId) async {
    var url = "http://localhost:3000/api/v1/profile/get"; // Assuming you have the correct API endpoint
    var box = Hive.box("user");
    var _jwt = box.get('jwt');

    var headers = {
      'Authorization': 'Bearer $_jwt',
      'Content-Type': 'application/json',
    };

    var dio = Dio();

    try {
      var response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
        queryParameters: {'id': userId},// Send userId as a query parameter
      );

      if (response.statusCode == 200) {
        return response.data; // Return profile data
      } else {
        print('Error: ${response.statusMessage}');
        return null; // Handle error response
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null; // Handle exceptions
    }
  }

}