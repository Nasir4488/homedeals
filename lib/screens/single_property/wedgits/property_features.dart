import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/textTheams.dart';

class PropertyFeatures extends StatelessWidget {
  final List<String> features;

  const PropertyFeatures({Key? key, required this.features}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
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
            "Features",
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
            alignment: Alignment.center,
            child: Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              children: [
                for (var feature in features!)
                  Container(
                    alignment: Alignment.center,
                    width: screenwidth * 0.16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (_) {},
                          fillColor: WidgetStateColor.transparent,
                          checkColor: Colors.grey,
                        ),
                        Text(
                          feature,
                          style: profileText,
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
