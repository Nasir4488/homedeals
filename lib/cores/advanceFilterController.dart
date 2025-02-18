import 'dart:async';
import 'package:dio/dio.dart' as dioo;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' as gett;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/property_model.dart';
import '../utils/constanats.dart';

class AdvanceFilter extends gett.GetxController {
  // Selected filters with default values
  String selectedLabel = label[0];
  String selectedStatus = propertyStatus[0];
  String selectedType = propertyTypes[0];

  // Map-related properties
  Set<Marker> markers = {};
  LatLng? currentLocation;
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  // Properties and API state
  List<Property> properties = [];
  int results = 0;
  bool isLoading = false;

  // Static locations for demo markers
  static const List<LatLng> randomLocations = [
    LatLng(37.42996133580664, -122.087749655962),
    LatLng(37.43096133580664, -122.089749655962),
    LatLng(37.43196133580664, -122.091749655962),
  ];

  // Default map position
  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.5,
  );

  /// **Fetches the user's current location and updates the map**
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      currentLocation = LatLng(position.latitude, position.longitude);

      // Add user's location marker (Red)
      _addMarker(
        id: 'current_location',
        position: currentLocation!,
        title: 'Your Location',
        hue: BitmapDescriptor.hueRed,
      );

      // Add predefined random green markers
      for (var loc in randomLocations) {
        _addMarker(
          id: loc.toString(),
          position: loc,
          hue: BitmapDescriptor.hueGreen,
        );
      }

      // Move camera to user's location
      if (mapController.isCompleted) {
        final GoogleMapController controller = await mapController.future;
        controller.animateCamera(CameraUpdate.newLatLngZoom(currentLocation!, 14));
      }

      update(); // Refresh UI
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  /// **Searches properties based on filters and fetches results**
  Future<List<Property>> searchProperties(Map<String, dynamic> filters) async {
    dioo.Dio dio = dioo.Dio();
    try {
      isLoading = true;
      update(); // Notify UI that loading has started

      dioo.Response response = await dio.get(
        'http://localhost:3000/api/v1/properties/filter',
        queryParameters: filters,
      );
      print("Full API Response: ${response.data}");
      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var data = response.data['data'];
        results = response.data["results"];
        print("Fetched $results properties");
        var propertiesList = data['properties'];
        if (propertiesList is List) {
          properties = propertiesList.map((item) => Property.fromJson(item)).toList();
          update(); // Update UI with new properties before returning
          return properties; // Now correctly returns the list
        }
      }
      results = response.data["results"] ?? 0;
      print("Fetched $results properties");

    } catch (e) {
      print("Error fetching properties: $e");
    } finally {
      isLoading = false;
      update(); // Ensure UI updates after the process completes
    }
    return []; // Return empty list if there's an error or no properties found
  }

  /// **Helper function to add a marker to the map**
  void _addMarker({required String id, required LatLng position, String? title, double hue = BitmapDescriptor.hueRed}) {
    markers.add(
      Marker(
        markerId: MarkerId(id),
        position: position,
        infoWindow: title != null ? InfoWindow(title: title) : InfoWindow.noText,
        icon: BitmapDescriptor.defaultMarkerWithHue(hue),
      ),
    );
  }
}
