import 'package:flutter/material.dart';
import 'package:homedeals/models/property_model.dart';

import '../../../utils/colors.dart';
import '../../../utils/textTheams.dart';

class Homeicons extends StatelessWidget {
  final Property property;
  const Homeicons({Key? key,required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.home_max),
        SizedBox(width: 5),
        Text("Home", style: profileText.copyWith(color: Colors.blue)),
        SizedBox(width: 5),
        Icon(Icons.arrow_forward_ios, size: 12, color: screenbackgroundColor),
        SizedBox(width: 5),
        Text("${property.type}",
            style: profileText.copyWith(color: Colors.blue)),
        SizedBox(width: 5),
        Icon(Icons.arrow_forward_ios, size: 12, color: screenbackgroundColor),
        SizedBox(width: 5),
        Text("${property.title}",
            style: profileText.copyWith(color: Colors.grey)),
        Spacer(),
        Row(
          children: [
            _buildActionButton("assets/icons/share.png", () {}),
            const SizedBox(width: 7),
            _buildActionButton("assets/icons/heart.png", () {}),
            const SizedBox(width: 7),
            _buildActionButton("assets/icons/printer.png", () {}),
          ],
        ),
      ],
    );
  }
}

Widget _buildActionButton(String assetPath, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Image.asset(assetPath),
    ),
  );
}

