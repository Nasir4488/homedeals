import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:homedeals/utils/routes.dart';
import '../../../models/property_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/textTheams.dart';
import 'small_botton.dart';
import 'package:cached_network_image/cached_network_image.dart';
class Filters extends StatelessWidget {
  final Future<List<Property>> searchPropertiesFuture;
  Filters({required this.searchPropertiesFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Property>>(
      future: searchPropertiesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No properties found.'));
        } else {
          var properties = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: properties.length,
            itemBuilder: (context, index) {
              var property = properties[index];
              var photoUrl = property.photos != null && property.photos!.isNotEmpty
                  ? property.photos![0]
                  : null;

              return Column(
                children: [
                  if (photoUrl != null && photoUrl.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: greyColor,
                            offset: Offset(0, 35),
                          ),
                        ],
                      ),
                      height: 220,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              filterQuality: FilterQuality.low,
                              imageUrl:photoUrl,
                              width: 180,
                              height: 180,
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) => Center(child: Text('Error loading image')),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    button_property(
                                      color: Colors.grey,
                                      title: property.status,
                                    ),
                                    SizedBox(width: 10),
                                    button_property(
                                      color: Colors.red,
                                      title: property.label,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  property.title,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  property.address,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: darkGreyColor),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Icon(Icons.bed_outlined),
                                    Text(
                                      property.bedrooms.toString(),
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: darkGreyColor),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.shower_rounded),
                                    Text(
                                      property.bathrooms.toString(),
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: darkGreyColor),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.car_crash_outlined),
                                    Text(
                                      property.features != null && property.features!.contains("parking") ? "1" : "",
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: darkGreyColor),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6,),
                                Text(
                                  property.type,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                SizedBox(height: 6,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      property.listingAgent.name,
                                      style: profileText,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      child: ElevatedButton(
                                        onPressed: ()async{
                                          // print(property.toJson());
                                          // print(property.id);
                                          // print(property.userId);
                                          var box = Hive.box('propertyBox');
                                          await box.put('selectedProperty', property);
                                          Get.toNamed(AllRoutes.singlePropertyScreen,arguments: property);
                                        },
                                        child: AutoSizeText("Details",style: buttontext!.copyWith(color: Colors.white),),
                                      ),
                                    ),


                                  ],
                                ),
                              ],
                            ),
                          ),

                      ])
                    )
                  else
                    Text('No image available for property: ${property.id}'),
                  SizedBox(height: 10),
                ],
              );
            },
          );
        }
      },
    );
  }
}
