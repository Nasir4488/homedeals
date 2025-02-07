import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildDropdown(double screenWidth, String hint, String currentValue,
    List<String> items, Function(String) onSelected, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade500, width: 1),
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    width: screenWidth * 0.15,
    height: 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              currentValue.isEmpty ? hint : currentValue,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.black),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: PopupMenuButton<String>(
            tooltip: "choose $hint",

            onSelected: onSelected,
            offset: Offset(0, 35),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  child: SizedBox(
                    width: screenWidth * 0.12, // Same width as the dropdown
                    height: 200, // Set max height for the dropdown menu
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: items.map((String item) {
                        return PopupMenuItem<String>(

                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ];
            },
            icon: Icon(
              Icons.arrow_downward,
              size: 18,
            ),
          ),
        )
      ],
    ),
  );
}