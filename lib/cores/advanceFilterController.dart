  import 'dart:async';
  import 'package:dio/dio.dart' as dioo;
import 'package:geolocator/geolocator.dart';
  import 'package:get/get.dart' as gett;
  import 'package:google_maps_flutter/google_maps_flutter.dart';
  import '../models/property_model.dart';
import '../utils/constanats.dart';

  class AdvanceFilter extends gett.GetxController {
    String selectedLabel = label[0];
    String selectedStatus = propertyStatus[0];
    String selectedType = propertyTypes[0];
    Set<Marker> markers = {};
    LatLng? currentLocation;
    int results = 0;
    bool isloading=false;

    List<Property> properties = [];


    final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

    static const List<LatLng> randomLocations = [
      LatLng(37.42996133580664, -122.087749655962),
      LatLng(37.43096133580664, -122.089749655962),
      LatLng(37.43196133580664, -122.091749655962),
    ];

    static const CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

    Future<void> getCurrentLocation() async {
      try {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        currentLocation = LatLng(position.latitude, position.longitude);

        markers.add(Marker(
          markerId: MarkerId('current_location'),
          position: currentLocation!,
          infoWindow: InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ));

        // Add random green markers
        for (var loc in randomLocations) {
          markers.add(Marker(
            markerId: MarkerId(loc.toString()),
            position: loc,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ));
        }

        if (mapController.isCompleted) {
          final GoogleMapController controller = await mapController.future;
          controller.animateCamera(CameraUpdate.newLatLngZoom(currentLocation!, 14));
        }

        update(); // Refresh UI
      } catch (e) {
        print("Error getting location: $e");
      }
    }

    Future<List<Property>> searchProperties(Map<String, dynamic> filter) async {
      dioo.Dio dio = dioo.Dio();
      try {
        isloading=true;
        dioo.Response response = await dio.get(
          'http://localhost:3000/api/v1/properties/filter',
          queryParameters: filter,
        );
        if (response.statusCode == 200) {
          var data = response.data['data'];
            results = response.data["results"];
            print(data.length);

          var propertiesList = data['properties'];
          if (propertiesList is List) {
            properties = [];
            for (var item in propertiesList) {
              properties.add(Property.fromJson(item));
            }
            update();
            return properties;
          }
        }
      } catch (e) {
        print("Error: $e");
      }
      finally{
        isloading=false;
        update();
      }
      // Return an empty list in case of an error or no properties found
      return [];
    }



  }
