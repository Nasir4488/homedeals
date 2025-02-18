import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../cores/advanceFilterController.dart';
import '../../../utils/colors.dart';
import '../../../utils/textTheams.dart';
class Filters extends StatelessWidget {
  final AdvanceFilter controller = Get.find<AdvanceFilter>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdvanceFilter>(
      builder: (controller) {
        if(controller.isLoading==true){
          return Container(height:50,width: 50,child: CircularProgressIndicator());
        }
        else if (controller.properties.isEmpty) {
          return Center(child: Text('No properties found.'));
        }

        else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.properties.length,
            itemBuilder: (context, index) {
              var property = controller.properties[index];
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
                            offset: Offset(0, 4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      height: 160,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              photoUrl,
                              width: 130,
                              height: 140,
                              fit: BoxFit.fill,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(child: CircularProgressIndicator());
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Center(child: Icon(Icons.error));
                              },
                            ),
                          ),
                          SizedBox(width: MediaQuery.sizeOf(context).width/5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(property.title, style: Theme.of(context).textTheme.bodyMedium),
                                SizedBox(height: 5),
                                Text(property.address, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: darkGreyColor)),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.bed_outlined),
                                    SizedBox(width: 5),
                                    Text(property.bedrooms.toString()),
                                    SizedBox(width: 15),
                                    Icon(Icons.shower_rounded),
                                    SizedBox(width: 5),
                                    Text(property.bathrooms.toString()),
                                  ],
                                ),
                                Expanded(child: SizedBox(height: 10)),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding:EdgeInsets.symmetric(horizontal: 14,vertical: 12)
                                  ),
                                  onPressed: () {
                                    // Uncomment and add functionality when navigating to details screen
                                    // Get.to(() => SinglePropertyScreen(property: property));
                                  },
                                  child: Text("View Details",style: textmediam!.copyWith(color: Colors.white),),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('No image available for property: ${property.id}', style: Theme.of(context).textTheme.bodySmall),
                    ),
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
