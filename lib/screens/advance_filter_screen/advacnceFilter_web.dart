import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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

  var locationController = TextEditingController();
  // SfRangeValues? _priceValues;
  SfRangeValues _priceValues = SfRangeValues(0.0, 10000.0);
  SfRangeValues _areaValues = SfRangeValues(0.0, 10000.0);
  String selectedBedroom = "Bedrooms";
  String selectedBathroom = "Bathrooms";
  bool radiusEnabled = true;
  int currentRadius = 0;
  int bedroom=bedrooms[0];
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

  List<String> countries = [];
  var advanceController=gett.Get.put(AdvanceFilter());



  Timer? _debounce;



  Future<void> _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      advanceController.getCurrentLocation();
    }
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
    advanceController.getCurrentLocation();

    // Fetch properties based on the filters
    _futureProperties = advanceController.searchProperties(filters);
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
                  Expanded(
                    flex: 1,

                    child: Container(
                      height: screenHeight,
                      child: gett.GetBuilder<AdvanceFilter>(
                        builder: (controller) {
                          return GoogleMap(
                            mapType: MapType.terrain,
                            initialCameraPosition: controller.currentLocation != null
                                ? CameraPosition(
                              target: controller.currentLocation!,
                              zoom: 14,
                            )
                                : AdvanceFilter.kGooglePlex,
                            markers: controller.markers,
                            onMapCreated: (GoogleMapController mapController) {
                              controller.mapController.complete(mapController);
                            },
                            myLocationButtonEnabled: true,
                            myLocationEnabled: true,
                            zoomControlsEnabled: true,
                          );
                        },
                      ),
                    ),
                  ),

                SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    height: screenHeight,
                    color: Colors.white,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        buildDropdown(
                      screenWidth,
                      "Select an item",
                      "asdsa",
                      ["Option 1", "Option 2", "Option 3", "Option 4"],
                          (String value) {
                        setState(() {
                          // selectedValue = value;
                        });
                      },
                      context,
                  ),
                        SizedBox(height: 20),
                        _buildFilterOptions(screenWidth),
                        SizedBox(height: 25),
                        _buildPriceRangeFilter(),
                        SizedBox(height: 20),
                        _buildAreaRange(),
                        SizedBox(height: 20),
                        // _buildSearchButton(screenWidth),
                        _buildSortOptions(screenWidth),
                        SizedBox(height: 20),
                        Filters(),

                      ],
                    ),
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

  // Search button

  // Widget _buildSearchButton(double screenWidth) {
  //   return Container(
  //     width: screenWidth,
  //     height: 50,
  //     child: ElevatedButton(
  //       onPressed: () async {
  //     setState(() {
  //       if (advanceController.country.value != countriesList[0]) {
  //         filters['country'] = advanceController.country.value;
  //       }
  //       _futureProperties = searchProperties(filters);
  //     });
  //       },
  //       child: Text(
  //         "Search",
  //         style: buttontext.copyWith(color: Colors.white),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSortOptions(double screenWidth) {
    return gett.GetBuilder<AdvanceFilter>(
      init: advanceController,
      builder: (controller)=>Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(controller.results.toString()),
            Container(

              child: buildDropdown(
                screenWidth,
                "Sorting Properties",
                selectedSort,
                sorts,
                (val) {
                  setState(() {
                    selectedSort = val;
                    filters["sort"] = sortMapping[val];
                    _futureProperties = advanceController.searchProperties(filters);
                  });
                },
                context,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding:EdgeInsets.symmetric(horizontal: 14,vertical: 12)
              ),
              onPressed: () {
                print(advanceController.searchProperties(filters));
              },
              child: Text("Search",style: textmediam!.copyWith(color: Colors.white),),
            ),

          ],
        ),
      ),
    );
  }
}