import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/cores/property_controller.dart';
import 'package:homedeals/screens/createlisting_screen/create_listing.dart';
import 'package:homedeals/utils/routes.dart';

import '../../../utils/constants.dart';
import '../../../utils/textTheams.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);
  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  var locationinfo = Get.put(PropertyController());

  Widget visible(ispost){
    return Visibility(
      visible: ispost,
        child: CircularProgressIndicator()
    );
  }
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Upload Complete"),
          content: Text(
              "The images have been uploaded. Do you want to stay on this page or go to the home page?"),
          actions: <Widget>[
            TextButton(
              child: Text("Stay"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Go to Home Page"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Get.toNamed(
                    AllRoutes.createListingPage); // Navigate to the home page
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Form(
      child: Container(
        margin: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
        padding: EdgeInsets.all(20),
        width: screenWidth,
        height: 500,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Locaton",
              style: mediamheading,
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width * 0.4,
                  child: Text("Address"),
                ),
                Container(
                  width: Get.width * 0.4,
                  child: Text("Country"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width * 0.4,
                  height: 50,
                  child: TextFormField(
                    controller: locationinfo.addressController,
                    cursorColor: Colors.black,
                    style: textfieldtext,
                    decoration: textFieldDecoration(
                        context: context, hint: "Enter Your Address"),
                  ),
                ),
                Container(
                  width: Get.width * 0.4,
                  height: 50,
                  child: TextFormField(
                    controller: locationinfo.countryController,
                    cursorColor: Colors.black,
                    style: textfieldtext,
                    decoration: textFieldDecoration(
                        context: context, hint: "title of your Country"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width * 0.4,
                  child: Text("State"),
                ),
                Container(
                  width: Get.width * 0.4,
                  child: Text("City"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width * 0.4,
                  height: 50,
                  child: TextFormField(
                    controller: locationinfo.stateController,
                    cursorColor: Colors.black,
                    style: textfieldtext,
                    decoration: textFieldDecoration(
                        context: context, hint: "title of your State"),
                  ),
                ),
                Container(
                  width: Get.width * 0.4,
                  height: 50,
                  child: TextFormField(
                    controller: locationinfo.cityController,
                    cursorColor: Colors.black,
                    style: textfieldtext,
                    decoration: textFieldDecoration(
                        context: context, hint: "title of your City"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width * 0.4,
                  child: Text("Zip code"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width * 0.4,
                  height: 50,
                  child: TextFormField(
                    controller: locationinfo.zipCodeController,
                    cursorColor: Colors.black,
                    style: textfieldtext,
                    decoration: textFieldDecoration(
                        context: context, hint: "title of your City"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () async {
                          // locationinfo.checking();
                          await locationinfo.uploadImages();
                          // _showDialog();
                          setState(() {
                          });
                        },
                        child:
                        Text(
                            "Submit Listing",
                            style: buttontext!.copyWith(color: Colors.white),
                          ),
                    ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
