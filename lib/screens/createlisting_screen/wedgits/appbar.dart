import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/utils/routes.dart';
import 'package:homedeals/utils/textTheams.dart';

import '../../../utils/constants.dart';
class Appbar extends StatefulWidget {
  const Appbar({Key? key}) : super(key: key);

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  @override
  Widget build(BuildContext context) {
    var screenheight=MediaQuery.of(context).size.height;
    var screenWidth=MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(left:screenWidth*0.04,right: 20,top: 20,bottom: 15),
      width: screenWidth,
      height: 80,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        children: [
          IconButton(onPressed: (){
            Get.toNamed(AllRoutes.homePage);
          }, icon: Icon(Icons.arrow_back_ios,size: 22,)),
          SizedBox(width: 20,),
          Text("Creat Listing",style: mediamheading,)
        ],
      ),
    );

  }
}
