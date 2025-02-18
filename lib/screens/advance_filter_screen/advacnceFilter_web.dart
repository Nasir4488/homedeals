import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as gett;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homedeals/cores/advanceFilterController.dart';
import 'package:homedeals/cores/countryController.dart';
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
  final String? status;
  final String? type;
  final int? price;
  final String? country;
  final int? bedrooms;
  final String? city;

  const AdvanceFilterWeb(
      {Key? key, this.status, this.type, this.price, this.country,this.bedrooms,this.city})
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

  List<String> bedroomOptions = ["Bedrooms"] + bedrooms.map((b) => b.toString()).toList();
  List<String> bathroomOptions = ["Bathrooms"] + bathrooms.map((b) => b.toString()).toList();

  String selectedLabel = label[0];
  String selectedCountry = gett.Get.parameters['country'] ?? "Choose Country";
  String selectedStatus = gett.Get.parameters['status'] ?? propertyStatus[0];
  String selectedType = gett.Get.parameters['type'] ?? propertyTypes[0];
  String selectedCity = gett.Get.parameters['city'] ?? "choose city";


  final Map<String, dynamic> filters = {};
  late Future<List<Property>> _futureProperties;
  List<String> countries = [];

  //controllers
  var advanceController=gett.Get.put(AdvanceFilter());
  var countryController=gett.Get.put(CountryController());

  Future<void> _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      advanceController.getCurrentLocation();
    }
  }

  //functions
  void _initializeFilters() {
    final params = gett.Get.parameters;

    // Parse and set price value
    double priceValue = double.parse(params['price']  ?? '10000');
    priceValue = (priceValue == 0.0) ? 10000.0 : priceValue;
    _priceValues = SfRangeValues(0.0, priceValue);
    filters['price[lte]'] = priceValue.toInt().toString();

    // Parse and set bedrooms
    if (params['bedrooms'] != null && params['bedrooms'] != 'Bedrooms') {
      bedroom = int.tryParse(params['bedrooms']!) ?? 0;
      if (bedroom > 0) {
        selectedBedroom=params['bedrooms'].toString();
        filters['bedrooms'] = bedroom.toString();
      }
    }

    // Add filters conditionally
    _addFilterIfValid('status', selectedStatus, propertyStatus);
    _addFilterIfValid('type', selectedType, propertyTypes);
    selectedCountry !="Country"? filters["country"] =selectedCountry:null;
    selectedCity !="City"? filters["city"] =selectedCity:null;

  }

  void _addFilterIfValid(String key, String value, List<String>? validList) {
    if (value != validList![0]) {
      filters[key] = value;
    }
  }
  Future<void> getIntialProperties() async{
    await advanceController.searchProperties(filters);
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async{
       _initializeFilters();
      _requestPermission();
     await countryController.getCountries();
     getIntialProperties();
    });

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

  bool _showSuggestions = false;


  Widget _buildFilterOptions(double screenWidth) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildDropdown(screenWidth, "Country", selectedCountry, countryController.countries,
                    (val) {
                  setState(() {
                    selectedCountry = val;
                    countryController.getCities(val);
                    val == "country"
                        ? filters.remove("country")
                        : filters['country'] = val;
                  });
                }, context),

            buildDropdown(screenWidth, "City", selectedCountry=="Choose Country"?"Choose Country First":selectedCity, countryController.cities,
                    (val) {
                  setState(() {
                    selectedCity = val;
                    val == "Default City"
                        ? filters.remove("city")
                        : filters['city'] = val;
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          ],
        ),
        SizedBox(height: 25),
        Row(
          children: [

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
  // Widget _buildSearchButton(double screenWidth) {
  //   return Container(
  //     width: screenWidth,
  //     height: 50,
  //     child: ElevatedButton(
  //       onPressed: () async {
  //     setState(() {
  //       _futureProperties = advanceController.searchProperties(filters);
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
              onPressed: () async{
                print("Filters $filters");

               await advanceController.searchProperties(filters);
              },
              child: Text("Search",style: textmediam!.copyWith(color: Colors.white),),
            ),

          ],
        ),
      ),
    );
  }
}