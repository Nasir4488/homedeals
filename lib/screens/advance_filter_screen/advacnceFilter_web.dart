import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' as gett;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homedeals/cores/advanceFilterController.dart';
import 'package:homedeals/models/property_model.dart';
import 'package:homedeals/screens/advance_filter_screen/widgets/buildDropdown.dart';
import 'package:homedeals/screens/advance_filter_screen/widgets/filteredPropertiesView.dart';
import 'package:homedeals/utils/constants.dart';
import 'package:homedeals/wedgits/appbar.dart';
import 'package:homedeals/wedgits/fotterSection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../utils/colors.dart';
import '../../utils/constanats.dart';
import '../../utils/textTheams.dart';

class AdvanceFilterWeb extends StatefulWidget {
  final String? label;
  final String? status;
  final String? type;
  final int? price;
  final String? country;
  final int? bedrooms;

  const AdvanceFilterWeb(
      {Key? key, this.status, this.type, this.label, this.price, this.country,this.bedrooms})
      : super(key: key);

  @override
  State<AdvanceFilterWeb> createState() => _AdvanceFilterWebState();
}

class _AdvanceFilterWebState extends State<AdvanceFilterWeb> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  var locationController = TextEditingController();
  // SfRangeValues? _priceValues;
  SfRangeValues _priceValues = SfRangeValues(0.0, 10000.0);
  SfRangeValues _areaValues = SfRangeValues(0.0, 10000.0);
  String selectedBedroom = "Bedrooms";
  String selectedBathroom = "Bathrooms";
  bool radiusEnabled = true;
  int currentRadius = 0;
  int bedroom=bedrooms[0];
  List<Property> properties = [];
  int results = 0;
  String selectedSort = sorts[0];
  List<String> bedroomOptions =
      ["Bedrooms"] + bedrooms.map((b) => b.toString()).toList();
  List<String> bathroomOptions =
      ["Bathrooms"] + bathrooms.map((b) => b.toString()).toList();
  String selectedLabel = gett.Get.parameters['label'] ?? label[0];
  String selectedCountry = gett.Get.parameters['country'] ?? countriesList[0];
  String selectedStatus = gett.Get.parameters['status'] ?? propertyStatus[0];
  String selectedType = gett.Get.parameters['type'] ?? propertyTypes[0];
  final Map<String, dynamic> filters = {};
  late Future<List<Property>> _futureProperties;
  Set<Marker> _markers = {};
  LatLng? _currentLocation;
  List<String> countries = [];
  var advanceController=gett.Get.put(AdvanceFilter());

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const List<LatLng> _randomLocations = [
    LatLng(37.42996133580664, -122.087749655962),
    LatLng(37.43096133580664, -122.089749655962),
    LatLng(37.43196133580664, -122.091749655962),
  ];
  Timer? _debounce;

  void _filterCountries(String input) {
    // Convert input to lowercase for case-insensitive comparison
    final lowercaseInput = input.toLowerCase();

    setState(() {
      _filteredCountries = countries
          .where((country) => country.toLowerCase().startsWith(lowercaseInput))
          .toList();
      _showSuggestions = _filteredCountries.isNotEmpty;
    });
  }

  Future<void> _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);

      _markers.add(Marker(
        markerId: MarkerId('current_location'),
        position: _currentLocation!,
        infoWindow: InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));

      // Add random green markers
      for (var loc in _randomLocations) {
        _markers.add(Marker(
          markerId: MarkerId(loc.toString()),
          position: loc,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ));
      }
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(_currentLocation!, 14));
  }

  @override
  void initState() {
    super.initState();
    double priceValue = double.tryParse(gett.Get.parameters['price'] != null &&
                gett.Get.parameters['price'] != '0'
            ? gett.Get.parameters['price']!
            : '10000') ??
        10000.0;

    if (selectedBedroom != "Bedrooms") {
      bedroom = int.tryParse(selectedBedroom) ?? 0; // Parse bedroom string to int
      if (bedroom > 0) {
        filters['bedrooms'] = bedroom.toString(); // Add to filters
      }
    }
    // selectedBedroom = gett.Get.parameters['bedrooms'] ?? '0' ?? 0;
    _priceValues = SfRangeValues(0.0, priceValue);
    filters['price[lte]'] = priceValue.toInt().toString();
    // Initialize the values from the passed parameters
    selectedLabel = gett.Get.parameters['label'] ?? label[0];
    selectedStatus = gett.Get.parameters['status'] ?? propertyStatus[0];
    selectedType = gett.Get.parameters['type'] ?? propertyTypes[0];
    selectedCountry = gett.Get.parameters['country'] ?? countriesList[0];
    // print(selectedStatus);

    // Apply the filters if they are set
    // if (selectedBedRoom != bedroomOptions[0]) {
    //   filters['bedrooms'] = selectedBedRoom;
    // }

    if (selectedStatus != propertyStatus[0]) {
      filters['status'] = selectedStatus;
    }
    if (selectedType != propertyTypes[0]) {
      filters['type'] = selectedType;
    }
    if(selectedCountry!=countriesList[0]){
      filters['country']= selectedCountry;
    }

    // Log the parameters to the console for debugging
    // Request location permission and get current location
    _requestPermission();
    _getCurrentLocation();

    // Fetch properties based on the filters
    _futureProperties = searchProperties(filters);
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    _futureProperties = searchProperties(filters);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: 100,
            width: screenWidth,
            child: appBarForWeb(context),
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  width: screenWidth / 2 - 40,
                  height: screenHeight,
                  child: _currentLocation == null
                      ? Center(child: CircularProgressIndicator())
                      : GoogleMap(
                          mapType: MapType.terrain,
                          initialCameraPosition: _kGooglePlex,
                          markers: _markers,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          zoomGesturesEnabled: false,
                          myLocationButtonEnabled: true,
                          zoomControlsEnabled: true,
                          scrollGesturesEnabled: true,
                          rotateGesturesEnabled: true,
                          myLocationEnabled: true,
                          mapToolbarEnabled: true,
                        ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  height: screenHeight,
                  width: screenWidth / 2,
                  color: Colors.white,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      _buildLocationInput(),
                      SizedBox(height: 20),
                      // _buildRadiusFilter(),
                      // SizedBox(height: 25),
                      _buildFilterOptions(screenWidth),
                      SizedBox(height: 25),
                      _buildPriceRangeFilter(),
                      SizedBox(height: 20),
                      _buildAreaRange(),
                      SizedBox(height: 20),
                      _buildSearchButton(screenWidth),
                      _buildSortOptions(screenWidth),
                      Filters(searchPropertiesFuture: _futureProperties),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: screenWidth,
            child: Fotter(),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInput() {
    return Container(
      height: 40,
      child: dropDown(list: countriesList),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  List<String> _filteredCountries = [];
  bool _showSuggestions = false;

  Widget _buildFilterOptions(double screenWidth) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildDropdown(screenWidth, "Type", selectedType, propertyTypes,
                (val) {
              setState(() {
                selectedType = val;
                val == "Default Type"
                    ? filters.remove("type")
                    : filters['type'] = val;
              });
            }, context),
            buildDropdown(screenWidth, "Label", selectedLabel, selectedType=="Commercial"?comercial:selectedType=="Industrial"?industrial:selectedType=="Land"?land:label, (val) {
              setState(() {
                selectedLabel = val;
                val == "Default Label"
                    ? filters.remove("label")
                    : filters['label'] = val;
              });
            }, context),
            buildDropdown(screenWidth, "Status", selectedStatus, propertyStatus,
                (val) {
              setState(() {
                selectedStatus = val;
                val == "Default Status"
                    ? filters.remove("status")
                    : filters['status'] = val;
              });
            }, context),
          ],
        ),
        SizedBox(height: 25),
        Row(
          children: [
            buildDropdown(
                screenWidth, "Bedrooms", selectedBedroom, bedroomOptions,
                (val) {
              setState(() {
                selectedBedroom=val;
                selectedBedroom == "Bedrooms" ||selectedBedroom==0
                    ? filters.remove("bedrooms")
                    : filters["bedrooms"] = selectedBedroom;
              });
            }, context),
            SizedBox(width: 10),
            buildDropdown(
                screenWidth, "Bathrooms", selectedBathroom, bathroomOptions,
                (val) {
              setState(() {
                selectedBathroom = val;
                selectedBathroom == "Bathrooms"
                    ? filters.remove("bathrooms")
                    : filters["bathrooms"] = selectedBathroom;
              });
            }, context),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceRangeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 12),
          child: AutoSizeText(
            "Select Price Range",
            style: buttontext,
          ),
        ),
        Container(
          child: SfRangeSlider(
            min: 0.0,
            max: 10000.0,
            values: _priceValues,
            showLabels: true,
            enableTooltip: true,
            showTicks: false,
            activeColor: blueColor,
            onChanged: (SfRangeValues values) {
              setState(() {
                _priceValues = values;
                _priceValues = SfRangeValues(
                  values.start.toInt(),
                  values.end.toInt(),
                );
                filters['price[gte]'] = values.start.toInt().toString();
                filters['price[lte]'] = values.end.toInt().toString();
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAreaRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 12),
          child: AutoSizeText(
            "Select Area Range",
            style: buttontext,
          ),
        ),
        Container(
          child: SfRangeSlider(
            min: 0.0,
            max: 10000.0,
            values: _areaValues,
            showLabels: true,
            enableTooltip: true,
            showTicks: false,
            activeColor: blueColor,
            onChanged: (SfRangeValues values) {
              setState(() {
                _areaValues = values;

                filters['area[gte]'] = values.start.toInt().toString();
                filters['area[lte]'] = values.end.toInt().toString();
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchButton(double screenWidth) {
    return Container(
      width: screenWidth,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            if(advanceController.country.value!=countriesList[0]){
              filters['country']=advanceController.country.value;
            }
            _futureProperties = searchProperties(filters);

          });
        },
        child: Text(
          "Search",
          style: buttontext.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSortOptions(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(results.toString()),
        Container(
          padding: EdgeInsets.all(10),
          child: buildDropdown(
            screenWidth,
            "Sorting Properties",
            selectedSort,
            sorts,
            (val) {
              setState(() {
                selectedSort = val;
                filters["sort"] = sortMapping[val];
                _futureProperties = searchProperties(filters);
              });
            },
            context,
          ),
        ),
        ElevatedButton(onPressed: ()async
        {

        }, child: Text("print"))
      ],
    );
  }

  Future<List<Property>> searchProperties(Map<String, dynamic> filter) async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        'http://localhost:3000/api/v1/properties/filter',
        queryParameters: filter,
      );
      if (response.statusCode == 200) {
        var data = response.data['data'];
        setState(() {
          results = response.data["results"];
          print(data.length);
        });
        var propertiesList = data['properties'];
        if (propertiesList is List) {
          properties = [];
          for (var item in propertiesList) {
            properties.add(Property.fromJson(item));
          }
          return properties;
        }
      }
    } catch (e) {
      print("Error: $e");
    }
    // Return an empty list in case of an error or no properties found
    return [];
  }
}

class dropDown extends StatefulWidget {
  final List<String> list;
  const dropDown({Key? key,required this.list}) : super(key: key);

  @override
  State<dropDown> createState() => _dropDownState();
}

class _dropDownState extends State<dropDown> {
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  var advanceController=gett.Get.put(AdvanceFilter());
  String _normalizeString(String input) {
    return input.replaceAll(RegExp(r'[^a-zA-Z]'), '').toLowerCase();
  }
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: greyColor,
          width: 1,
        ),
            borderRadius: BorderRadius.circular(6)
      ),
      child: DropdownButtonHideUnderline(
        child: gett.Obx(
          () => DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              'Select Item',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: widget.list
                .map((item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ))
                .toList(),
            value: advanceController.country.value,
            onChanged: (value) {
              setState(() {
                advanceController.country.value = value!;
                print(advanceController.country.value);
              });
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 200,
            ),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 200,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: textEditingController,
              searchInnerWidgetHeight: 60,
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  style: TextStyle(
                    fontSize:12
                  ),
                  controller: textEditingController,
                  decoration: textFieldDecoration(context: context),

                ),
              ),
              searchMatchFn: (item, searchValue) {
                final normalizedItem = _normalizeString(item.value.toString());
                final normalizedSearch = _normalizeString(searchValue);

                return normalizedItem.contains(normalizedSearch);
              },
            ),
            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingController.clear();
              }
            },
          ),
        ),
      ),
    );
  }
}
