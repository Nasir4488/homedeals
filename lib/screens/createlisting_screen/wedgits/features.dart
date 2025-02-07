import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/cores/property_controller.dart';
import '../../../utils/constants.dart';
import '../../../utils/textTheams.dart';

class Features extends StatefulWidget {
  const Features({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeaturesState();
  }
}

class _FeaturesState extends State<StatefulWidget> {
  var features=Get.put(PropertyController());
  List<bool> amenities = [
    false, // air_conditions
    false, // barbique
    false, // dryer
    false, // gym
    false, // loundry
    false, // loan
    false, // outDoor_shower
    false, // refirigritor
    false, // swimming_pool
    false, // tv_cabel
    false, // washer
    false, // wifi
    false, // Windows
  ];

  List<String> amenityLabels = [
    "Air Conditioner",
    "Barbique",
    "Dryer",
    "Gaurge",
    "Gym",
    "Loundry",
    "Loan",
    "Outdoor Shower",
    "Refrigerator",
    "Swimming Pool",
    "TV Cable",
    "Washer",
    "WiFi",
    "Windows",
  ];


  @override
  Widget build(BuildContext context) {
    var screenheight=MediaQuery.of(context).size.height;
    var screenWidth=MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
      padding: EdgeInsets.all(20),
      width: screenWidth,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Features',
            style: mediamheading
          ),
          Divider(),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: (amenities.length / 4).ceil(),
              itemBuilder: (context, index) {
                int startIndex = index * 4;
                int endIndex = startIndex + 4;
                if (endIndex > amenities.length) {
                  endIndex = amenities.length;
                }
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      endIndex - startIndex,
                          (subIndex) {
                        int amenityIndex = startIndex + subIndex;
                        return Container(
                          width: screenWidth*0.20,
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: blueColor,
                                value: amenities[amenityIndex],
                                onChanged: (val) {
                                  setState(() {
                                    amenities[amenityIndex] = val!;
                                    if(amenities[amenityIndex]==true){
                                      features.features.add(amenityLabels[amenityIndex]);
                                    }
                                    else{
                                      features.features.remove(amenityLabels[amenityIndex]);
                                    }
                                    print(features.features);
                                  });
                                },
                              ),
                              Text(
                                amenityLabels[amenityIndex],
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );


  }
}
