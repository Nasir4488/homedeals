import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/textTheams.dart';
class PropertyDescription extends StatelessWidget {
  final String description;
  const PropertyDescription({Key? key, required this.description}) : super(key: key);

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
            "Description",
            style: textmediam,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 30,
          ),
          AutoSizeText(
            description,
            style: profileText,
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
