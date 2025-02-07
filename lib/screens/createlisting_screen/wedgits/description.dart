import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/cores/property_controller.dart';

import '../../../utils/constants.dart';
import '../../../utils/textTheams.dart';

class Description extends StatefulWidget {
  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  final PropertyController propertyController = Get.put(PropertyController());

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Form(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        padding: EdgeInsets.all(20),
        width: screenWidth,
        height: 450,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description",
              style: mediamheading,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenWidth * 0.4,
                  child: Text(
                    "Title*",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,
                  ),
                ),
                Container(
                  width: screenWidth * 0.4,
                  child: Text(
                    "Price*",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenWidth * 0.4,
                  height: 50,
                  child: TextFormField(
                    controller: propertyController.titleController,
                    cursorColor: Colors.black,
                    style: textfieldtext,
                    decoration: textFieldDecoration(
                      context: context,
                      hint: "Property title",
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * 0.4,
                  height: 50,
                  child: TextFormField(
                    controller: propertyController.priceController,
                    cursorColor: Colors.black,
                    style: textfieldtext,
                    decoration: textFieldDecoration(
                      context: context,
                      hint: "Property price",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              "Content",
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenWidth * 0.25,
                  child: Text("Type", style: subheading),
                ),
                Container(
                  width: screenWidth * 0.25,
                  child: Text("Label", style: subheading),
                ),
                Container(
                  width: screenWidth * 0.25,
                  child: Text("Status", style: subheading),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  width: screenWidth * 0.25,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        propertyController.
                            typeController.text == "" ? propertyTypes[0]:propertyController.typeController.text,
                        overflow: TextOverflow.ellipsis,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                      ),
                      PopupMenuButton<String>(
                        initialValue: propertyTypes[0],
                        onSelected: (String value) {
                          propertyController.typeController
                              .text = value;
                          print(value);
                          setState(() {

                          });
                        },
                        tooltip: "Property type",
                        offset: Offset(0, 35),
                        itemBuilder: (BuildContext context) {
                          return propertyTypes.map((String type) {
                            return PopupMenuItem<String>(
                              padding: EdgeInsets.only(right: 60, left: 20),
                              value: type,
                              child: Text(type),
                            );
                          }).toList();
                        },
                        icon: Icon(
                          Icons.arrow_downward,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  width: screenWidth * 0.25,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        propertyController.labelController
                            .text == "" ? propertyTypes[0] : propertyController
                            .labelController.text,
                        overflow: TextOverflow.ellipsis,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                      ),
                      PopupMenuButton<String>(
                        initialValue: label[0],
                        onSelected: (String value) {
                          propertyController.labelController
                              .text = value;
                          print(value);
                          setState(() {
                          });
                        },
                        tooltip: "Property type",
                        offset: Offset(0, 35),
                        itemBuilder: (BuildContext context) {
                          List<String> items;
                          print(propertyController.typeController.text);

                          // Define the items based on the property type
                          if (propertyController.typeController.text == "Commercial") {
                            items = comercial; // Assuming `commercial` is a predefined List<String>
                          } else if (propertyController.typeController.text == "Industrial") {
                            items = industrial; // Assuming `industrial` is a predefined List<String>
                          }
                          else if (propertyController.typeController.text == "Land") {
                            items = industrial; // Assuming `industrial` is a predefined List<String>
                          }
                          else if (propertyController.typeController.text == "Developers projects") {
                            items = land; // Assuming `industrial` is a predefined List<String>
                          }
                          else if (propertyController.typeController.text == "Residential") {
                            items = residential; // Assuming `industrial` is a predefined List<String>
                          }
                          else {
                            items = allLabels; // Default or empty list
                          }
                          return items.map((String type) {
                            return PopupMenuItem<String>(
                              padding: EdgeInsets.only(right: 60, left: 20),
                              value: type,
                              child: Text(type),
                            );
                          }).toList();
                        },
                        icon: Icon(
                          Icons.arrow_downward,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  width: screenWidth * 0.25,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        propertyController.statusController
                            .text == "" ? propertyStatus[0] : propertyController
                            .statusController.text,
                        overflow: TextOverflow.ellipsis,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                      ),
                      PopupMenuButton<String>(
                        initialValue: propertyTypes[0],
                        onSelected: (String value) {
                          propertyController.statusController
                              .text = value;
                          print(value);
                          setState(() {});
                        },
                        tooltip: "Property type",
                        offset: Offset(0, 35),
                        itemBuilder: (BuildContext context) {
                          return propertyStatus.map((String type) {
                            return PopupMenuItem<String>(
                              padding: EdgeInsets.only(right: 60, left: 20),
                              value: type,
                              child: Text(type),
                            );
                          }).toList();
                        },
                        icon: Icon(
                          Icons.arrow_downward,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Container(height: 130,
              child: TextField(
                controller: propertyController.descriptionController,
                maxLines: 20,
                cursorColor: Colors.black,
                style: textfieldtext,
                decoration: textFieldDecoration(
                  context: context,
                  hint: "Property description",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
