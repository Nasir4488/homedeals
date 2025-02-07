import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/cores/property_controller.dart';

import '../../../utils/constants.dart';
import '../../../utils/textTheams.dart';
class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
var details=Get.put(PropertyController());
  @override
  Widget build(BuildContext context) {
    var screenheight=MediaQuery.of(context).size.height;
    var screenWidth=MediaQuery.of(context).size.width;
    return Form(
      child: Container(
        margin: EdgeInsets.only(left: 50,right: 50,top: 20,bottom: 20),
        padding: EdgeInsets.all(20),
        width: screenWidth,
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Details",style: mediamheading,),
            Divider(),
            Text("Title*",style: Theme.of(context).textTheme.bodyMedium,),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width*0.4,
                  child: Text("BedRooms"),),
                Container(
                  width: Get.width*0.4,
                  child: Text("BathRoom"),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width*0.4,
                  height: 50,
                  child: TextFormField(
                    controller: details.bedroomsController,
                    cursorColor: Colors.black,
                    style: textfieldtext,
                    decoration: textFieldDecoration(context: context,hint: "Number of Bedroom"),
                  ),
                ),
                Container(
                  width: Get.width*0.4,
                  height: 50,
                  child: TextFormField(
                    controller: details.bathroomsController,

                    cursorColor: Colors.black,
                    style: textfieldtext,
                    decoration: textFieldDecoration(context: context,hint: "Number of BathRooms"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width*0.4,
                  child: Text("Enter Area Size"),),
                Container(
                  width: Get.width*0.4,
                  child: Text("Enter size guarge if any"),),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width*0.4,
                  height: 50,
                  child: TextFormField(
                    controller: details.squareFootageController,
                    cursorColor: Colors.black,
                    style: textfieldtext,
                    decoration: textFieldDecoration(context: context,hint: "Area of Property"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
