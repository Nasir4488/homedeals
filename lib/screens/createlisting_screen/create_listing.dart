import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/screens/createlisting_screen/create_listing_web.dart';
import '../../utils/colors.dart';
import '../../utils/constanats.dart';

class CreateListing extends StatefulWidget {
  const CreateListing({Key? key}) : super(key: key);

  @override
  State<CreateListing> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CreateListing> {
  @override
  Widget build(BuildContext context) {
    var screenheight=MediaQuery.of(context).size.height;
    var screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            double windowWidth = Get.width;

            if (windowWidth <= DeviceWidths.tabletWidthMin) {
              return Text("Mobile");
            }
            else if (windowWidth >= DeviceWidths.tabletWidthMin &&
                windowWidth <= DeviceWidths.tabletWidthMax) {
              return Container(
                child: Text("Tablet"),
              ); // Replace TabletLayout with your tablet layout widget
            }
            else {
              return Container(
                  child: CreateListingWeb()); // Replace DesktopLayout with your desktop layout widget
            }
          },
        ));
  }
}
