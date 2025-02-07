import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/cores/homeController.dart';
import 'package:homedeals/models/countryModel.dart';
import 'package:homedeals/utils/routes.dart';
import '../../../cores/countryController.dart';
import '../../../utils/constants.dart';
import '../../../wedgits/appbar.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  var token = "";
  var dio = Dio();
  Map<String, dynamic>? countriesData;
  String selectedLabel = label[0];
  late String selectedStatus ;
  String selectedCountry="Default";
  String selectedType = propertyTypes[0];
  String catagory = "Property Type";
  List<String> priceStrings =
      ["Any"] + prices.map((int price) => price.toString()).toList();
  List<String> bedroomsString =
      ["Any"] + bedrooms.map((int bedrooms) => bedrooms.toString()).toList();
  int selectedPrice = 0;
  int selectedBedRooms=0;
  List<String> countries=[];
  int val = 0;
  CountryController countryController = CountryController();
  HomeController homeController = HomeController();
  Map<String,dynamic> data={};

@override
  void initState() {
  if(countryController.countries!=null ||countryController.countries.isNotEmpty){
    countryController.getCountries();
  }
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: Get.height * 0.9,
      child: Stack(
        children: [
          Container(
              height: Get.height * 0.8,
              color: Color(0xFF0C73FE),
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage('assets/images/home_bg.jpg'),
              //     fit: BoxFit.cover,
              //   ),
              // )
          ),
          // Positioned(
          //   top: 0,
          //   child: Container(
          //     height: Get.height * 0.8,
          //     width: Get.width,
          //     color: Colors.black.withOpacity(0.4),
          //   ),
          // ),
          Positioned(
              child: Container(
            width: Get.width,
            child: appBarForWeb(context),
          )),
          // Positioned(
          //   top: Get.height * .11,
          //   child: Container(
          //     color: Colors.white,
          //     width: Get.width,
          //     height: 1,
          //   ),
          // ),

          Positioned(
            top: Get.height * 0.1,
            child: Container(
              height: Get.height * 0.6,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Search your dream property",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: whiteColor,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0,

                    ),
                  ),
                  // Text(
                  //   "Houzez is an innovative real estate WordPress theme that helps to ensure your",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .bodyMedium!
                  //       .copyWith(color: whiteColor),
                  // ),
                  // Text(
                  //   "website’s success in this super-competitive market.",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .bodyMedium!
                  //       .copyWith(color: whiteColor),
                  // ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // for sale
                          InkWell(
                            onTap: () {
                              selectedStatus=propertyStatus[1];

                              homeController.filterButton(0);
                            },
                            child: Obx(() => Container(
                              alignment: Alignment.center,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: homeController.active == 0
                                      ? Colors.white
                                      : Colors.blue.shade500.withOpacity(0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(8)
                                  )
                              ),
                              height: 50,
                              child: AutoSizeText(
                                'For Sale',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                    color: homeController.active == 0
                                        ? Colors.black
                                        : whiteColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          //For Rent
                          InkWell(
                            onTap: () {
                              selectedStatus=propertyStatus[2];
                              homeController.filterButton(1);
                            },
                            child: Obx(() => Container(
                              alignment: Alignment.center,
                              width: 150,
                              decoration: BoxDecoration(

                                  color: homeController.active == 1
                                      ? Colors.white
                                      : Colors.blue.shade500.withOpacity(0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(8)
                                  )),
                              height: 50,
                              child: AutoSizeText(
                                'For Rent',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                    color: homeController.active == 1
                                        ? Colors.black
                                        : whiteColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              selectedStatus=propertyStatus[3];
                              homeController.filterButton(2);
                            },
                            child: Obx(() => Container(
                              alignment: Alignment.center,
                              width: 150,
                              decoration: BoxDecoration(

                                  color: homeController.active == 2
                                      ? Colors.white
                                      : Colors.blue.shade500.withOpacity(0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(8)
                                  )),
                              height: 50,
                              child: AutoSizeText(
                                'Auction',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                    color: homeController.active == 2
                                        ? Colors.black
                                        : whiteColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          // All Status
                          InkWell(
                            onTap: () {
                              selectedStatus=propertyStatus[4];
                              homeController.filterButton(3);
                            },
                            child: Obx(() => Container(
                              alignment: Alignment.center,
                              width: 150,
                              decoration: BoxDecoration(

                                  color: homeController.active == 3
                                      ? Colors.white
                                      : Colors.blue.shade500.withOpacity(0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              height: 50,
                              child: AutoSizeText(
                                'Developer Option',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                    color: homeController.active == 3
                                        ? Colors.black
                                        : whiteColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                          ),
                        ],
                      ),
                      SizedBox(height: 25,),
                      Container(
                        width: Get.width * 0.8,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: screenWidth * 0.13,
                                      height: 30,
                                      child: AutoSizeText(
                                        //COuntry
                                        "Country",
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      )),
                                  Container(
                                      width: screenWidth * 0.13,
                                      height: 30,
                                      child: AutoSizeText(
                                        //Property type
                                        "City",
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      )),
                                  Container(
                                      width: screenWidth * 0.13,
                                      height: 30,
                                      child: AutoSizeText(
                                        //COuntry
                                        "Property Type",
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      )),
                                  Container(
                                      width: screenWidth * 0.13,
                                      height: 30,
                                      child: AutoSizeText(
                                        //Bedrooms
                                        "Bedrooms",
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      )),
                                  Container(
                                      width: screenWidth * 0.13,
                                      height: 30,
                                      child: AutoSizeText(
                                        //
                                        "Price",
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      )),
                                  Container(
                                      width: screenWidth * 0.13,
                                      height: 30,
                                      child: AutoSizeText("           ")),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  buildDropdown(screenWidth, "Country", selectedCountry,
                                      countryController.countries, (val) {
                                        setState(() {
                                          selectedCountry=val;
                                        });
                                      }, context),
                                  buildDropdown(screenWidth, "Country", selectedCountry,
                                      countriesList, (val) {
                                        setState(() {
                                          selectedCountry=val;
                                        });
                                      }, context),
                                  buildDropdown(
                                      screenWidth, "Type", selectedType, propertyTypes,
                                          (val) {
                                        setState(() {
                                          selectedType = val;
                                          // val == "Default Type"
                                          //     ? filters.remove("type")
                                          //     : filters['type'] = val;
                                        });
                                      }, context),
                                  buildDropdown(
                                      screenWidth, "Bedrooms", selectedBedRooms==0?"Any":selectedBedRooms.toString(), bedroomsString, (val) {
                                    setState(() {
                                      if(val == "Any"){
                                        selectedBedRooms=0;
                                      }
                                      else {
                                        selectedBedRooms = int.parse(
                                            val); // Convert back to int after selection
                                      }
                                      // selectedBedroom == "Bedrooms"
                                      //     ? filters.remove("bedrooms")
                                      //     : filters["bedrooms"] = selectedBedroom;
                                    });
                                  }, context),
                                  buildDropdown(
                                    screenWidth,
                                    "Select Price",
                                    selectedPrice == 0 ? "Any" : selectedPrice.toString(),
                                    priceStrings,
                                        (val) {
                                      setState(() {
                                        if (val == "Any") {
                                          selectedPrice =
                                          0; // Reset to 0 if "Any" is selected
                                        } else {
                                          selectedPrice = int.parse(
                                              val); // Convert back to int after selection
                                        }
                                      });
                                    },
                                    context,
                                  ),
                                  Container(
                                      width: screenWidth * 0.13,
                                      height: 50,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Get.toNamed(AllRoutes.advancefilter,
                                                parameters: {
                                                  // "label": selectedLabel,
                                                  "country":selectedCountry,
                                                  "status": selectedStatus,
                                                  "type": selectedType,
                                                  "bedrooms":selectedBedRooms.toString(),
                                                  "price": selectedPrice.toString(),
                                                });
                                          },
                                          child: AutoSizeText(
                                            "Search",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: Colors.white),
                                          )
                                      )
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      // FutureBuilder<dynamic>(
                      //   future: countries,
                      //   builder: (context, snapshot) {
                      //     if (snapshot.connectionState == ConnectionState.waiting) {
                      //       return Center(child: CircularProgressIndicator());
                      //     } else if (snapshot.hasError) {
                      //       return Center(child: Text('Error: ${snapshot.error}'));
                      //     } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                      //       return Center(child: Text('No countries available.'));
                      //     } else {
                      //       final rawData = snapshot.data as List; // Cast raw data to List
                      //       final countryList = rawData.map((json) => Country.fromJson(json)).toList();
                      //       return ListView.builder(
                      //         itemCount: countryList.length,
                      //         itemBuilder: (context, index) {
                      //           final country = countryList[index];
                      //           return ListTile(
                      //             title: Text(country.country),
                      //             subtitle: Text('Cities: ${country.cities.join(', ')}'),
                      //           );
                      //         },
                      //       );
                      //     }
                      //   },
                      // ),

                    ],
                  ),

                ],
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.635,
            child: Container(
              decoration: BoxDecoration(

              ),
              width: Get.width,
              // child: ,
            ),
          ),
          // Positioned(
          //   left: Get.width * 0.1,
          //   top: Get.height * 0.7,
          //   // child: Container(
          //   //   width: Get.width * 0.8,
          //   //   height: 130,
          //   //   decoration: BoxDecoration(
          //   //     border: Border.all(color: Colors.red, width: 2),
          //   //     color: Colors.white,
          //   //     borderRadius: BorderRadius.circular(6),
          //   //     boxShadow: [
          //   //       BoxShadow(
          //   //         color: Colors.grey.shade300, // Shadow color
          //   //         spreadRadius: 1, // Spread radius
          //   //         blurRadius: 1,
          //   //         offset: Offset(0, 3),
          //   //       ),
          //   //     ],
          //   //   ),
          //   //   child: Column(
          //   //     mainAxisAlignment: MainAxisAlignment.start,
          //   //     children: [
          //   //       SizedBox(
          //   //         height: 20,
          //   //       ),
          //   //       Container(
          //   //         margin: EdgeInsets.symmetric(horizontal: 40),
          //   //         child: Row(
          //   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   //           children: [
          //   //             Container(
          //   //                 width: screenWidth * 0.13,
          //   //                 height: 30,
          //   //                 child: AutoSizeText(
          //   //                   //COuntry
          //   //                   "Type",
          //   //                   style: Theme.of(context).textTheme.bodyMedium,
          //   //                 )),
          //   //             Container(
          //   //                 width: screenWidth * 0.10,
          //   //                 height: 30,
          //   //                 child: AutoSizeText(
          //   //                   //Property type
          //   //                   "Label",
          //   //                   style: Theme.of(context).textTheme.bodyMedium,
          //   //                 )),
          //   //             Container(
          //   //                 width: screenWidth * 0.13,
          //   //                 height: 30,
          //   //                 child: AutoSizeText(
          //   //                   //Bedrooms
          //   //                   "Status",
          //   //                   style: Theme.of(context).textTheme.bodyMedium,
          //   //                 )),
          //   //             Container(
          //   //                 width: screenWidth * 0.13,
          //   //                 height: 30,
          //   //                 child: AutoSizeText(
          //   //                   //
          //   //                   "Price",
          //   //                   style: Theme.of(context).textTheme.bodyMedium,
          //   //                 )),
          //   //             Container(
          //   //                 width: screenWidth * 0.13,
          //   //                 height: 30,
          //   //                 child: AutoSizeText("           ")),
          //   //           ],
          //   //         ),
          //   //       ),
          //   //       Container(
          //   //         margin: EdgeInsets.symmetric(horizontal: 40),
          //   //         child: Row(
          //   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   //           children: [
          //   //             buildDropdown(
          //   //                 screenWidth, "Type", selectedType, propertyTypes,
          //   //                 (val) {
          //   //               setState(() {
          //   //                 selectedType = val;
          //   //                 // val == "Default Type"
          //   //                 //     ? filters.remove("type")
          //   //                 //     : filters['type'] = val;
          //   //               });
          //   //             }, context),
          //   //             buildDropdown(
          //   //                 screenWidth, "label", selectedLabel, label, (val) {
          //   //               setState(() {
          //   //                 selectedLabel = val;
          //   //                 // selectedBedroom == "Bedrooms"
          //   //                 //     ? filters.remove("bedrooms")
          //   //                 //     : filters["bedrooms"] = selectedBedroom;
          //   //               });
          //   //             }, context),
          //   //             buildDropdown(screenWidth, "Status", selectedStatus,
          //   //                 propertyStatus, (val) {
          //   //               setState(() {
          //   //                 // selectedStatus = val;
          //   //                 // val == "Default Label"
          //   //                 //     ? filters.remove("label")
          //   //                 //     : filters['label'] = val;
          //   //               });
          //   //             }, context),
          //   //             buildDropdown(
          //   //               screenWidth,
          //   //               "Select Price",
          //   //               selectedPrice == 0 ? "Any" : selectedPrice.toString(),
          //   //               priceStrings,
          //   //               (val) {
          //   //                 setState(() {
          //   //                   if (val == "Any") {
          //   //                     selectedPrice =
          //   //                         0; // Reset to 0 if "Any" is selected
          //   //                   } else {
          //   //                     selectedPrice = int.parse(
          //   //                         val); // Convert back to int after selection
          //   //                   }
          //   //                 });
          //   //               },
          //   //               context,
          //   //             ),
          //   //             Container(
          //   //                 width: screenWidth * 0.13,
          //   //                 height: 50,
          //   //                 child: ElevatedButton(
          //   //                     onPressed: () {
          //   //                       Get.toNamed(AllRoutes.advancefilter,
          //   //                           parameters: {
          //   //                             "label": selectedLabel,
          //   //                             "status": selectedStatus,
          //   //                             "type": selectedType,
          //   //                             "price": selectedPrice.toString(),
          //   //                           });
          //   //                     },
          //   //                     child: AutoSizeText(
          //   //                       "Search",
          //   //                       style: Theme.of(context)
          //   //                           .textTheme
          //   //                           .bodyMedium!
          //   //                           .copyWith(color: Colors.white),
          //   //                     )
          //   //                 )
          //   //             )
          //   //           ],
          //   //         ),
          //   //       ),
          //   //     ],
          //   //   ),
          //   // ),
          // ),
        ],
      ),
    );
  }

  Future<void> changeLocale() async {
    Get.rootController.restartApp();
  }
}


Widget buildDropdown(double screenWidth, String hint, String currentValue,
    List<String> items, Function(String) onSelected, BuildContext context) {
  ScrollController scrollController = ScrollController();
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade500, width: 1),
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    alignment: Alignment.center,
    width: screenWidth * 0.12,
    height: 50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              currentValue.isEmpty ? hint : currentValue,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.black),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: PopupMenuButton<String>(
            tooltip: "Choose $hint",
            onSelected: onSelected,
            offset: Offset(0, 35),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  child: SizedBox(
                    width: screenWidth * 0.12, // Same width as the dropdown
                    height: 200, // Set max height for the dropdown menu
                    child: Scrollbar(
                      controller: scrollController,
                      thumbVisibility: true, // Always show the scrollbar thumb
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        children: items.map((String item) {
                          return PopupMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ];
            },
            icon: Icon(Icons.keyboard_arrow_down,size: 22,),
            ),

          ),

      ],
    ),
  );
}
