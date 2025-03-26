import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:homedeals/models/property_model.dart';

import '../../../utils/textTheams.dart';

class PropertyDetailsDialog extends StatelessWidget {
  final  Property property;

  PropertyDetailsDialog({required this.property});

  CarouselSliderController buttonCarouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    if (property.photos == null || property.photos!.isEmpty) {
      return Center(child: Text('No photos available.'));
    }
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close Icon in Top-Right Corner
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close, size: 30, color: Colors.red),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*.7,
                  height: MediaQuery.of(context).size.height*.7,

                  child: CarouselSlider(
                    carouselController: buttonCarouselController,
                    items: property.photos!.map((photo) {
                      return Builder(
                        builder: (context) {
                          return Image.network(
                            photo,
                            fit: BoxFit.cover, // Show full image
                          );
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      aspectRatio: 2.0,
                      initialPage: 0,
                    ),
                  ),

                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.2,
                  height: MediaQuery.of(context).size.height*0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height:40,
                              child: Text("Title :",style: navtext,)),
                          Container(                              height:40,
                              child: Text("Price :",style: navtext,)),
                          Container(                              height:40,
                              child: Text("Address :",style: navtext,)),
                      ]
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Container(                              height:40,
                                child: Text(property.title,style: profileText,)),
                            Container(                              height:40,
                                child: Text(property.price.toString(),style: profileText,)),
                            Container(
                              width: MediaQuery.of(context).size.width*.13,
                              child: Text(
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                maxLines: null,
                                property.address,
                                style: profileText,

                              ),
                            )
                          ]
                      ),
                    ],
                  ),

                ),
              ],
            ),


            SizedBox(width: 20),
            SizedBox(height: 20,),

            // Next Button
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            buttonCarouselController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          },
          child: Text('←',style: subheading!.copyWith(color: Colors.white),),
        ),
        SizedBox(width: 10,),
        ElevatedButton(
          onPressed: () {
            buttonCarouselController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          },
          child: Text('→',style: subheading!.copyWith(color: Colors.white),),
        ),

      ],
    )

          ],
        ),
      ),
    );
  }
}
