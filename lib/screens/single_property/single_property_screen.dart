import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart' as gett;
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homedeals/cores/crudPropertiesController.dart';
import 'package:homedeals/models/property_model.dart';
import 'package:homedeals/screens/single_property/wedgits/carasoulOverViewCalenderSection.dart';
import 'package:homedeals/screens/single_property/wedgits/description.dart';
import 'package:homedeals/screens/single_property/wedgits/homeIcons.dart';
import 'package:homedeals/screens/single_property/wedgits/property_address.dart';
import 'package:homedeals/screens/single_property/wedgits/property_features.dart';
import 'package:homedeals/screens/single_property/wedgits/relatedProperties.dart';
import 'package:homedeals/utils/colors.dart';
import 'package:homedeals/utils/constanats.dart';
import 'package:homedeals/utils/textTheams.dart';
import 'package:homedeals/wedgits/appbar.dart';
import 'package:homedeals/wedgits/fotterSection.dart';

class SinglePropertyScreen extends StatefulWidget {
  SinglePropertyScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SinglePropertyScreen> createState() => _SinglePropertyScreenState();
}

class _SinglePropertyScreenState extends State<SinglePropertyScreen> {
  int currentSlide = 0;
  int results = 0;
  List<Property> properties = [];
  int columnHeight = 0;
  var crudProperties = Get.put(Crudpropertiescontroller());
  DateTime selectedDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(Duration(days: 15));
  final Property property = Get.arguments as Property;


  @override
  void initState() {
    getRelatedProperties();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          appBarForWeb(context),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                      horizontal: screenwidth * 0.12,
                      vertical: screenwidth * 0.025),
                  children: [
                    // share print and favorit icons
                    Homeicons(property: property,),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(property.title ?? 'No Title',
                            style: mediamheading),
                        Text("\$${property.price?.toString() ?? 'N/A'}",
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        button_property(
                            color: greenColor, title: property.type ?? 'N/A'),
                        SizedBox(width: 5),
                        button_property(
                            color: Colors.grey, title: property.label ?? 'N/A'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.pin_drop_outlined,
                            color: Colors.grey, size: 14),
                        SizedBox(width: 8),
                        Text(property.address ?? 'No Address',
                            style: profileText),
                      ],
                    ),
                    SizedBox(height: 30),


                    if (property.photos != null && property.photos!.isNotEmpty)
                      Carasoulplusoverviewsection(property: property,)
                    else
                      Center(child: Text('No images available')),
                    SizedBox(
                      height: 10,
                    ),

                    //Description Section

                    PropertyDescription(
                      description: property.description.toString(),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //Address Section

                    PropertyAddress(property: property),
                    SizedBox(
                      height: 10,
                    ),

                    //Features Section

                    PropertyFeatures(
                      features: property.features!.toList(),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    //Releated  Properties

                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      width: screenwidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          AutoSizeText(
                            "Related Properties",
                            style: textmediam,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(),
                          SizedBox(
                            height: 25,
                          ),
                          Wrap(
                            runSpacing: 10,
                            spacing: 20,
                            children: [
                              for (var relatedProperty in properties)
                                Container(
                                  width:
                                      screenwidth <= DeviceWidths.tabletWidthMax
                                          ? screenwidth * 0.32
                                          : screenwidth * 0.22,
                                  child: Relatedproperties(
                                    property: relatedProperty,
                                  ),
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Fotter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getRelatedProperties() async {
    properties = [];
    Map<String, dynamic> filter = {"type": property.type};
    properties = await crudProperties.searchProperties(filter, property.id);
      setState(() {});

  }
}

Widget button_property(
    {required String title, required Color color, onpress()?}) {
  return Container(
      height: 25,
      width: gett.Get.width * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: color.withOpacity(0.7),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Text(title,
            style: textsmall.copyWith(
                color: Colors.white, overflow: TextOverflow.ellipsis)),
      ));
}
