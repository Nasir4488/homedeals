import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:homedeals/models/property_model.dart';

import '../../../utils/colors.dart';
import '../../../utils/textTheams.dart';

class PropertyAddress extends StatelessWidget {
  final Property property;
  const PropertyAddress({Key? key,required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenwidth=MediaQuery.of(context).size.width;
    return Container(
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
            height: 30,
          ),
          AutoSizeText(
            "Address",
            style: textmediam,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenwidth * .27,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      AutoSizeText(
                        "adress",
                        style: textmediam,
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      AutoSizeText(
                        "City",
                        style: textmediam,
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      AutoSizeText(
                        "State",
                        style: textmediam,
                      ),
                      Divider(),
                    ],
                  ),
                ),
                Container(
                  width: screenwidth * .27,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      AutoSizeText(
                        property.address,
                        style: profileText,
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      AutoSizeText(
                        property.city,
                        style: profileText,
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      AutoSizeText(
                        property.state,
                        style: profileText,
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
