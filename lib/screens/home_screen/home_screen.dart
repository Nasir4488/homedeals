import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/constanats.dart';
import 'home_mobile.dart';
import 'home_web.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
      builder: (context, constraints) {
        double windowWidth = MediaQuery.of(context).size.width;

        if (windowWidth <= DeviceWidths.tabletWidthMin) {
          return HomeMobile();
        }

        else if (windowWidth >= DeviceWidths.tabletWidthMin &&
            windowWidth <= DeviceWidths.tabletWidthMax) {
          return Container(
            child: Text("Tablet"),
          ); // Replace TabletLayout with your tablet layout widget
        }

        else {
          return Container(
              child: HomeWeb()); // Replace DesktopLayout with your desktop layout widget
        }
      },
    ));
  }
}
