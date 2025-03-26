import 'dart:html';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/cores/homeController.dart';
import 'package:homedeals/screens/home_screen/wedgits/dropDownPriceBed.dart';
import 'package:homedeals/screens/home_screen/wedgits/propertiesDropDown.dart';
import 'package:homedeals/screens/home_screen/wedgits/statusButtons.dart';
import 'package:homedeals/utils/textTheams.dart';
import '../../../cores/countryController.dart';
import '../../../utils/constants.dart';
import '../../../utils/routes.dart';
import '../../../wedgits/appbar.dart';
import '../../../wedgits/dropDownWithSearch.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  var token = "";
  var dio = Dio();

  var homeController = Get.put(HomeController());
  var countryController = Get.put(CountryController());

  String selectedStatus = propertyStatus[1];
  String selectedCountry = "Country";
  String selectedLabel = "";
  String selectedType = "";
  int selectedIPrice = 0;
  int selectedFPrice = 0;
  int selectedBedRooms = 0;
  String selectedCity = "City";
  int val = 0;
  Map<String, dynamic>? countriesData;
  String catagory = "Property Type";

  List<String> countries = [];
  Map<String, dynamic> data = {};


  @override
  void initState() {
    countryController.getCountries();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    countryController.cities.clear();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.9,
      child: Stack(
        children: [
          Container(
            height: screenHeight * 0.8,
            color: Color(0xFF0C73FE),
          ),
          Positioned(
              child: Container(
            width: screenWidth,
            child: appBarForWeb(context),
          )),
          Positioned(
            top: screenHeight * 0.1,
            child: Container(
              height: screenHeight * 0.6,
              width: screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Search Your Dream Property",
                      style: textlarge!.copyWith(color: Colors.white)),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // for sale changing to
                          StatusButtons(propertyStatus[1], 0, context),

                          SizedBox(
                            width: 5,
                          ),
                          //For Rent
                          StatusButtons(propertyStatus[2], 2, context),

                          SizedBox(
                            width: 5,
                          ),
                          //For Auction
                          StatusButtons(propertyStatus[3], 3, context),

                          SizedBox(
                            width: 5,
                          ),
                          StatusButtons(propertyStatus[4], 4, context),
                          // All Status
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: screenWidth * 0.8,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300, // Shadow color
                              spreadRadius: 1, // Spread radius
                              blurRadius: 1,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),

                            //Titles For Filters
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),

                            ),
                            //Input for Filters
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: screenWidth * 0.12,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade500,
                                            width: 1),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: DropdownWithSearch(
                                        title: "Country",
                                        list: countryController.countries,
                                        // Automatically updates UI
                                        flags: countryController.flags,
                                        onItemSelected: (selected) async {
                                          selectedCountry = selected;
                                          int index = countryController
                                              .countries
                                              .indexOf(selectedCountry);
                                          if (index != -1) {
                                            String isoCode =
                                                countryController.countryCodes[
                                                    index]; // Get the ISO code
                                            setState(() {
                                              print(isoCode);

                                              countryController.getCities(
                                                  isoCode); // Fetch cities using ISO code
                                            });
                                          }
                                        },
                                      )),
                                  Container(
                                      width: screenWidth * 0.12,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade500,
                                            width: 1),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: GetBuilder(
                                          init: countryController,
                                          builder: (controller) {
                                            return DropdownWithSearch(
                                              title: "City",
                                              list: controller.cities,
                                              onItemSelected: (selected) async {
                                                selectedCity = selected;
                                                setState(() {});
                                              },
                                            );
                                          })),
                                  Container(
                                    width: screenWidth * 0.12,
                                    // Dynamic width based on screen size
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade500,
                                          width: 1),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),

                                    child: TypeDropDown(
                                      title: "Properties",
                                      menu: menu,
                                      onItemSelected: (List<String> selected) {
                                        setState(() {
                                          selectedLabel = selected[0];
                                          selectedType = selected[1];
                                        });
                                      },
                                    ),
                                  ),
                                  // Bedroom
                                  Container(
                                    width: screenWidth * 0.12,
                                    // Dynamic width based on screen size
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade500,
                                          width: 1),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: CustomIntDropDown(
                                      header: "bedroom",
                                      list: [
                                        ">0",
                                        "1",
                                        "2",
                                        "3",
                                        "4",
                                        "5",
                                        "6",
                                        "7",
                                        "8",
                                        "9"
                                      ],
                                      title: "Bedrooms",
                                      onItemSelected: (value) {
                                        selectedBedRooms = value == ">0"
                                            ? 0
                                            : int.parse(value);
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.12,
                                    // Dynamic width based on screen size
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade500,
                                          width: 1),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: CustomIntDropDown(
                                      header: "price",
                                      // list: [">0","1", "2", "3", "4", "5", "6", "7", "8", "9"],
                                      list :[
                                        ">0", "500", "1000", "5000", "10000", "50000", "100000", "500000", "1000000", "2000000",
                                        "3000000", "4000000", "5000000", "6000000", "7000000", "8000000", "9000000", "10000000", "11000000", "12000000"
                                      ],
                                      flist : [
                                        ">0", "1000", "5000", "10000", "50000", "100000", "500000", "1000000", "2000000", "3000000",
                                        "4000000", "5000000", "6000000", "7000000", "8000000", "9000000", "10000000", "11000000", "12000000", "13000000", "14000000"
                                      ],
                                      title: "Price",

                                      onItemSelected: (value) {
                                        selectedIPrice = value == ">0" ? 0 : int.parse(value);
                                      },
                                      onItemFSelected: (value) {
                                        selectedFPrice = value == ">0" ? 0 : int.parse(value);
                                      },
                                    ),
                                  ),

                                  Container(
                                      width: screenWidth * 0.13,
                                      height: 50,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Get.toNamed(AllRoutes.advancefilter,
                                                parameters: {
                                                  "city" :selectedCity,
                                                  "country":selectedCountry,
                                                  "status": homeController.selectedStatus.value,
                                                  "type": selectedType,
                                                  "bedrooms":selectedBedRooms.toString(),
                                                  "intialPrice": selectedIPrice.toString(),
                                                  "finalPrice": selectedFPrice.toString(),
                                                });
                                          },
                                          child: AutoSizeText(
                                            "Search",
                                            style: buttontext,
                                          )))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.635,
            child: Container(
              decoration: BoxDecoration(),
              width: screenWidth,
              // child: ,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> changeLocale() async {
    Get.rootController.restartApp();
  }
}
Widget filterTitles(
    {required double screenWidth,
    required BuildContext context,
    required String title}) {
  return Container(
      width: screenWidth * 0.13,
      height: 30,
      child: AutoSizeText(title, style: subheading));
}


