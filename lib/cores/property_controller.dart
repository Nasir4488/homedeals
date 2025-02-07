import 'dart:convert';
import 'dart:math';

import 'package:file_selector/file_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../models/property_model.dart'; // Replace with your actual model path

class PropertyController extends GetxController {

  RxList<Uint8List> images = <Uint8List>[].obs;
  RxList<String> imageUrls = <String>[].obs;
  List<String> features = [];


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance.ref("properties");

  final Random random = Random();
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

  @override
  void onInit() {
    token = box.get('jwt'); // Initialize token or set as an empty string
    if (token.isEmpty ||isTokenExpired(token)) {
      print("Token not found or is expired.....Refreshing");
      refreshToken();
      token = box.get('jwt'); // Initialize token or set as an empty string

    } else {
      print("Token initialized: $token");
    }
    // TODO: implement onInit
    super.onInit();
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController currencyController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController bedroomsController = TextEditingController();
  final TextEditingController bathroomsController = TextEditingController();
  final TextEditingController squareFootageController = TextEditingController();
  final TextEditingController lotSizeController = TextEditingController();
  final TextEditingController yearBuiltController = TextEditingController();
  final TextEditingController furnishingController = TextEditingController();
  final TextEditingController listingAgentEmailController = TextEditingController();
  final TextEditingController listingAgentPhoneController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController photosController = TextEditingController();
  final TextEditingController videosController = TextEditingController();
  final TextEditingController labelController = TextEditingController();
  var box = Hive.box("user");
  late String token;
  Future<String> _uploadToFirebaseStorage(Uint8List fileData, String fileName) async {
    try {
      var task = _storage.child('${_auth.currentUser!.uid}/$fileName');
      var uploadTask = await task.putData(fileData);
      var url = await task.getDownloadURL();
      return url;
    } catch (e) {
      print("Error uploading file: $e");
      return '';
    }
  }

  void addImages(List<XFile> files) async {
    for (var file in files) {
      images.add(await file.readAsBytes());
    }
  }

  void clearImages() {
    images.clear();
  }
  //
  Future<void> uploadImages() async {
    for (var i = 0; i < images.length; i++) {
      var fileData = images[i];
      var fileName = 'image_${DateTime.now().millisecondsSinceEpoch}';
      String url = await _uploadToFirebaseStorage(fileData, fileName);
      if (url.isNotEmpty) {
        imageUrls.add(url);
      }
      saveProperty();
    }
    print(imageUrls);
  }
  void removeImage(int index) {
    images.removeAt(index);
  }

  Future<void> saveProperty() async {
    if (!_validateInputs()) {
      return;
    }
    try {
      Property property = Property(
        userId: _auth.currentUser!.uid,
        title: titleController.text,
        description: descriptionController.text,
        type: typeController.text,
        price: double.parse(priceController.text),
        currency: currencyController.text,
        address: addressController.text,
        city: cityController.text,
        state: stateController.text,
        country: countryController.text,
        zipCode: zipCodeController.text,
        latitude: latitudeController.text.isNotEmpty ? double.parse(latitudeController.text) : null,
        longitude: longitudeController.text.isNotEmpty ? double.parse(longitudeController.text) : null,
        bedrooms: int.parse(bedroomsController.text),
        bathrooms: int.parse(bathroomsController.text),
        // yearBuilt: DateTime.now().toString(),
        listingAgent: ListingAgent(
          name: _auth.currentUser!.displayName ?? 'Unknown',
          email: _auth.currentUser!.email ?? 'Unknown',
          phone: _auth.currentUser!.phoneNumber ?? 'Unknown',
        ),
        status: statusController.text,
        photos: imageUrls,
        videos: videosController.text.isNotEmpty ? [videosController.text] : null,
        label: labelController.text,
        features: features,
        isfeatured: false,
      );
      clearImages();
      var dio = Dio();
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      var data=property.toJson();
      var response = await dio.request(
        'http://localhost:3000/api/v1/properties/postProperty',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: json.encode(data),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        Get.snackbar('Success', 'Property saved successfully');
      } else {
        print(response.statusMessage);
        // Get.snackbar('Error', 'Failed to save property: ${response.statusMessage}');
        print(response.statusMessage);
      }
      clearImages();
      Get.snackbar('Success', 'Property saved successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save property: $e');
    }
    finally {
      // Set saving state to false to hide circular progress indicator
    }
  }

  bool _validateInputs() {
    // Map of field names to their corresponding controllers
    Map<String, TextEditingController> fields = {
      'Description': descriptionController,
      'Price': priceController,
      'Address': addressController,
      'City': cityController,
      'State': stateController,
      'Country': countryController,
      'Zip Code': zipCodeController,
      'Bedrooms': bedroomsController,
      'Bathrooms': bathroomsController,
    };

    // List to hold the names of missing fields
    List<String> missingFields = [];

    // Check if any of the required fields are empty
    fields.forEach((name, controller) {
      if (controller.text.isEmpty) {
        missingFields.add(name);
      }
    });

    // If there are missing fields, show an error message
    if (missingFields.isNotEmpty) {
      String missingFieldsMessage = 'Please fill out the following fields: ${missingFields.join(', ')}';
      Get.snackbar('Error', missingFieldsMessage);
      return false;
    }

    // Validate specific fields for correct types and values
    if (!isNumeric(priceController.text)) {
      Get.snackbar('Error', 'Price must be a valid number.');
      return false;
    }

    if (!isNumeric(bedroomsController.text)) {
      Get.snackbar('Error', 'Bedrooms must be a valid number.');
      return false;
    }

    if (!isNumeric(bathroomsController.text)) {
      Get.snackbar('Error', 'Bathrooms must be a valid number.');
      return false;
    }

    // Validate enums

    // Additional validation checks can be added here for other fields like latitude, longitude, etc.
    if (latitudeController.text.isNotEmpty && !isNumeric(latitudeController.text)) {
      Get.snackbar('Error', 'Latitude must be a valid number.');
      return false;
    }
    if (longitudeController.text.isNotEmpty && !isNumeric(longitudeController.text)) {
      Get.snackbar('Error', 'Longitude must be a valid number.');
      return false;
    }
    return true;
  }
// Helper function to check if a string is numeric
  bool isNumeric(String str) {
    if (str.isEmpty) {
      return false;
    }
    final number = num.tryParse(str);
    return number != null;
  }
}
