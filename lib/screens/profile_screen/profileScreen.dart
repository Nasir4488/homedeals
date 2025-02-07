import 'package:flutter/material.dart';
import 'package:homedeals/screens/profile_screen/profile_web.dart';

import '../../utils/constanats.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double windowWidth = MediaQuery.of(context).size.width;

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
                child: PropfileScreen_Web()); // Replace DesktopLayout with your desktop layout widget
          }
        },
      ),
    );
  }
}
