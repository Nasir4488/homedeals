import 'package:flutter/material.dart';

import '../../../utils/textTheams.dart';

Widget buildDropdown(
    double screenWidth,
    String hint,
    String currentValue,
    List<String> items,
    Function(String) onSelected,
    BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade500, width: 1),
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    width: screenWidth * 0.15,
    height: 40,
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: PopupMenuButton<String>(
      tooltip: "Choose $hint",
      onSelected: onSelected,
      offset: Offset(0, 40), // Adjusted for better positioning
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      itemBuilder: (BuildContext context) {
        return items.map((String item) {
          return PopupMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              currentValue.isEmpty ? hint : currentValue,
              overflow: TextOverflow.ellipsis,
              style: subheading,
            ),
          ),
          Icon(Icons.arrow_drop_down, size: 20),
        ],
      ),
    ),
  );
}
