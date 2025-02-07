import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/screens/advance_filter_screen/advacnceFilter_web.dart';
import 'package:homedeals/utils/constanats.dart';

class AdvanceFilter extends StatefulWidget {

  const AdvanceFilter({Key? key}) : super(key: key);

  @override
  State<AdvanceFilter> createState() => _AdvanceFilterState();
}

class _AdvanceFilterState extends State<AdvanceFilter> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double windowWidth = MediaQuery.of(context).size.width;

        if (windowWidth <= DeviceWidths.tabletWidthMin) {
          return Text("Mobile");
        }
        else  {
          return Container(
            child:AdvanceFilterWeb(),
          ); // Replace TabletLayout with your tablet layout widget
        }

      },
    );
  }
}
