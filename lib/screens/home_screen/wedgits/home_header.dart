import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/cores/homeController.dart';
import '../../../cores/countryController.dart';
import '../../../utils/constants.dart';
import '../../../utils/routes.dart';
import '../../../wedgits/appbar.dart';

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
  String selectedType = propertyTypes[0];
  int selectedPrice = 0;
  int selectedBedRooms = 0;
  String selectedCity="City";
  int val = 0;
  Map<String, dynamic>? countriesData;
  String catagory = "Property Type";

  List<String> countries = [];
  Map<String, dynamic> data = {};
  List<String> priceStrings =
      ["Any"] + prices.map((int price) => price.toString()).toList();
  List<String> bedroomsString =
      ["Any"] + bedrooms.map((int bedrooms) => bedrooms.toString()).toList();

  @override
  void initState() {
    countryController.getCountries();

    // TODO: implement initState
    super.initState();
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
                  Text(
                    "Search your dream property",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: whiteColor,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0,
                        ),
                  ),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),

                            //Titles For Filters
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  filterTitles(
                                      context: context,
                                      screenWidth: screenWidth,
                                      title: "Countries"),
                                  filterTitles(
                                      context: context,
                                      screenWidth: screenWidth,
                                      title: "City"),
                                  filterTitles(
                                      context: context,
                                      screenWidth: screenWidth,
                                      title: "Property Type"),
                                  filterTitles(
                                      context: context,
                                      screenWidth: screenWidth,
                                      title: "Bedrooms"),
                                  filterTitles(
                                      context: context,
                                      screenWidth: screenWidth,
                                      title: "Price"),
                                  filterTitles(
                                      context: context,
                                      screenWidth: screenWidth,
                                      title: "           "),
                                ],
                              ),
                            ),

                            //Input for Filters
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildDropdown(
                                      screenWidth,
                                      "Country",
                                      selectedCountry,
                                      countryController.countries, (val) {
                                    setState(() {
                                      selectedCountry = val;
                                      countryController.getCities(val);
                                    });
                                  }, context),
                                  buildDropdown(screenWidth, "Cities",
                                      selectedCity, countryController.cities, (val) {
                                    setState(() {
                                      print(countryController.cities);
                                      selectedCity = val;
                                    });
                                  }, context,isEnabled: selectedCountry!="Default"),
                                  buildDropdown(screenWidth, "Type",
                                      selectedType, propertyTypes, (val) {
                                    setState(() {
                                      selectedType = val;
                                    });
                                  }, context),
                                  buildDropdown(
                                      screenWidth,
                                      "Bedrooms",
                                      selectedBedRooms == 0
                                          ? "Any"
                                          : selectedBedRooms.toString(),
                                      bedroomsString, (val) {
                                    setState(() {
                                      if (val == "Any") {
                                        selectedBedRooms = 0;
                                      } else {
                                        selectedBedRooms = int.parse(
                                            val); // Convert back to int after selection
                                      }
                                    });
                                  }, context),
                                  buildDropdown(
                                    screenWidth,
                                    "Select Price",
                                    selectedPrice == 0
                                        ? "Any"
                                        : selectedPrice.toString(),
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
                                            // print(homeController.selectedStatus);

                                            Get.toNamed(AllRoutes.advancefilter,
                                                parameters: {
                                                  "city" :selectedCity,
                                                  "country":selectedCountry,
                                                  "status": homeController.selectedStatus.value,
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

Widget buildDropdown(
    double screenWidth,
    String hint,
    String currentValue,
    List<String> items,
    Function(String) onSelected,
    BuildContext context, {
      bool isEnabled = true,
    }) {
  // ScrollController for the dropdown list
  ScrollController scrollController = ScrollController();

  return Container(
    // Container decoration with border and rounded corners
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade500, width: 1),
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    alignment: Alignment.center,
    width: screenWidth * 0.12, // Dynamic width based on screen size
    height: 50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              currentValue.isEmpty ? hint : currentValue, // Display hint if no selection
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
            tooltip: "Choose $hint", // Tooltip for accessibility
            onSelected: isEnabled ? onSelected : null, // Disable selection if not enabled
            offset: Offset(0, 35), // Popup menu offset
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  child: SizedBox(
                    width: screenWidth * 0.12, // Match width of the dropdown
                    height: 200, // Set max height for dropdown list
                    child: Scrollbar(
                      controller: scrollController,
                      thumbVisibility: true, // Always show scrollbar
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        children: items.isEmpty
                            ? [ // If no items, show a placeholder
                          PopupMenuItem<String>(
                            value: "",
                            child: Text("No items available"),
                          )
                        ]
                            : items.map((String item) {
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
            icon: Icon(
              Icons.keyboard_arrow_down,
              size: 22,
            ),
          ),
        ),
      ],
    ),
  );
}


Widget StatusButtons(String statusLabel, int active, BuildContext context) {
  HomeController homeController = Get.find<HomeController>();

  return InkWell(
    onTap: () {
      homeController.filterButton(active,statusLabel); // Update active filter\
    },
    child: Obx(() => Container(
          alignment: Alignment.center,
          width: 150,
          decoration: BoxDecoration(
            color: homeController.active == active
                ? Colors.white
                : Colors.blue.shade500.withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          height: 50,
          child: AutoSizeText(
            statusLabel, // Use dynamic status label
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: homeController.active == active
                      ? Colors.black
                      : whiteColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        )),
  );
}

Widget filterTitles(
    {required double screenWidth,
    required BuildContext context,
    required String title}) {
  return Container(
      width: screenWidth * 0.13,
      height: 30,
      child: AutoSizeText(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ));
}
