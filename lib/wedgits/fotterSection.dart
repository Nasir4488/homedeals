import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homedeals/utils/constanats.dart';

import '../utils/constants.dart';
import '../utils/textTheams.dart';

class Fotter extends StatelessWidget {
  const Fotter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight=MediaQuery.of(context).size.height;
    var screenWidth=MediaQuery.of(context).size.width;
    return Column(
      children: [

        Container(
          padding: EdgeInsets.only(top: 30),
          height: 250,
          width: screenWidth,
          color: Color(0xFF0C73FE),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Discover",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),),
                  ...List.generate(4, (index) {
                    List<String> discover = [
                      'Miami',
                      'Los Angeles',
                      'Chicago',
                      'New York',
                    ];
                    return TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: whiteColor,
                              size: 4,
                            ),
                            SizedBox(width: 2),
                           Text(discover[index],style: Theme.of(context).textTheme.bodySmall!.copyWith(color: whiteColor),)                            ],
                        ));
                  }),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Discover",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),),

                  SizedBox(height: 14),
                  ...List.generate(3, (index) {
                    List<String> discover = [
                      ' 774 NE 84th St Miami, FL 33879',
                      '879 456 1349',
                      ' email@houzez.co',
                    ];
                    List<IconData> icons = [
                      Icons.location_on_outlined,
                      Icons.perm_phone_msg_sharp,
                      Icons.email_outlined,
                    ];
                    return TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              icons[index],
                              color: whiteColor,
                              size: 4,
                            ),
                            SizedBox(width: 2),
                            Text(discover[index],style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),)                            ],


                        ));
                  }),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Subscribe to our newsletter",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Container(
                        width: screenWidth*0.2,
                        height: 50,
                        child: TextFormField(
                          cursorColor: Colors.white,
                          style: textfieldtext!.copyWith(color: Colors.white),
                          decoration: InputDecoration(
                            suffixStyle: Theme.of(context!).textTheme.bodySmall!.copyWith(color: Colors.white),
                            hintText: "Enter Your Email",
                            alignLabelWithHint: true,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white, fontSize: 12),
                            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Adjust padding to center text
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      // InkWell(
                      //   onTap: (){},
                      //   child: Container(
                      //     height: screenHeight * 0.05,
                      //     width: screenWidth * 0.1,
                      //     decoration: BoxDecoration(
                      //       color: blueColor,
                      //       borderRadius:
                      //       BorderRadius.circular(5),
                      //     ),
                      //     child: Center(
                      //       child: Text("Submit",style: Theme.of(context).textTheme.bodyMedium,)
                      //     ),
                      //   ),
                      // ),
                      Container(
                          height: 50,
                          width: screenWidth*0.1,
                          child: ElevatedButton(onPressed: (){}, child: Text("Submit",  style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                          ),))
                    ],
                  ),
                  SizedBox(height: 14),
                  Text(

                    'Houzez is a premium WordPress theme for Designers & Real Estate Agents.',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                  ),
              ]),
            ],
          ),
        ),

        //   ///
        //   ///---------->   Footer Section Part 2
        //   ///

        Container(
          height: screenHeight * 0.15,
          width: screenWidth,
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                   '© Houzez - All rights reserved',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: whiteColor,),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: whiteColor,
                      size: 12,
                    ),
                    SizedBox(width: 2),
                    Text(
                      'houzez',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: whiteColor,),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: socialMediaUrls.length,
                      itemBuilder:
                          (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 3),
                          child: InkWell(
                            onTap: () {
                              switch (index) {
                                case 0:
                                // Facebook
                                  break;
                                case 1:
                                // Twitter
                                  break;
                                case 2:
                                // Linkedin
                                  break;
                                case 3:
                                // Instagram
                                  break;
                                case 4:
                                // Youtube
                                  break;
                                case 5:
                                // Whatsapp
                                  break;
                              }
                            },
                            child: Image.network(
                              socialMediaUrls[index],
                              height: 15.0,
                              width: 15.0,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
