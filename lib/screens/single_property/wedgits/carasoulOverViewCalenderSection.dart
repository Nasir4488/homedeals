import 'package:flutter/material.dart';
import 'package:homedeals/models/property_model.dart';

import '../../../utils/colors.dart';
import '../../../utils/constanats.dart';
import '../../../utils/textTheams.dart';
import 'calendar.dart';
import 'imageCarousel.dart';
class Carasoulplusoverviewsection extends StatefulWidget {
  final Property property;
  const Carasoulplusoverviewsection({Key? key,required this.property}) : super(key: key);

  @override
  State<Carasoulplusoverviewsection> createState() => _CarasoulplusoverviewsectionState();
}

class _CarasoulplusoverviewsectionState extends State<Carasoulplusoverviewsection> {
  bool seduleBotton = true;
  bool contact = false;
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;    return Container(
      color: whiteColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Image slider and OverView Section
          Expanded(
              child: Column(
            children: [
              ImageCarousel(property: widget.property),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                width: screenwidth,
                color: whiteColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Overview",
                      style: textmediam,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: screenwidth * .07,
                            child: Text(
                              widget.property.type,
                              style: buttontext,
                            )),
                        Container(
                            width: screenwidth * .07,
                            child: Text(
                              widget.property.bedrooms.toString(),
                              style: buttontext,
                            )),
                        Container(
                            width: screenwidth * .07,
                            child: Text(
                              widget.property.bathrooms.toString(),
                              style: buttontext,
                            )),
                        Container(
                            width: screenwidth * .07,
                            child: Text(
                              widget.property.features!.contains("Gaurge") ? "1" : "0",
                              style: buttontext,
                            )),
                        Container(
                            width: screenwidth * .07,
                            child: Text(
                              "insertion",
                              style: buttontext,
                            )),
                        Container(
                            width: screenwidth * .07,
                            child: Text(
                              "insertion",
                              style: buttontext,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: screenwidth * .07,
                            child: Text(
                              "Property Type",
                              style: profileText,
                            )),
                        Container(
                            width: screenwidth * .07,
                            child: Text(
                              "Bedrooms",
                              style: profileText,
                            )),
                        Container(
                            width: screenwidth * .07,
                            child: Text(
                              "Bathrooms",
                              style: profileText,
                            )),
                        Container(
                            width: screenwidth * .07,
                            child: Text(
                              "Gargur",
                              style: profileText,
                            )),
                        Container(
                            width: screenwidth * .07,
                            child: Text(
                              "Area",
                              style: profileText,
                            )),
                        Container(
                            width: screenwidth * .07,
                            child: Text(
                              "Year Build",
                              style: profileText,
                            )),
                      ],
                    )
                  ],
                ),
              ),

            ],
          )),
          screenwidth > DeviceWidths.tabletWidthMax
              ? Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      height: screenheight * 1.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                      width: screenwidth * 0.23,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    contact = false;
                                    seduleBotton = true;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: screenwidth * 0.115,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: seduleBotton
                                        ? whiteColor
                                        : Colors.grey.shade100,
                                  ),
                                  height: 50,
                                  child: Text('Sedule Meeting'),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    seduleBotton = false;
                                    contact = true;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: screenwidth * 0.115,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: contact
                                        ? whiteColor
                                        : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text('Contact'),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              CustomCalendar(),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Tour",
                                      style: textmediam,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 40,
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        style: textfieldtext,
                                        decoration: textFieldDecoration(
                                          context: context,
                                          hint: "Time",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 40,
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        style: textfieldtext,
                                        decoration: textFieldDecoration(
                                          context: context,
                                          hint: "Name",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 40,
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        style: textfieldtext,
                                        decoration: textFieldDecoration(
                                          context: context,
                                          hint: "Phone",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 40,
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        style: textfieldtext,
                                        decoration: textFieldDecoration(
                                          context: context,
                                          hint: "Email",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    TextField(
                                      maxLines: 5,
                                      style: textfieldtext,
                                      decoration: textFieldDecoration(
                                        context: context,
                                        hint: "Description",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                "By submitting this form I agree to ",
                                            style: subheading,
                                          ),
                                          TextSpan(
                                            text: "Terms of Use",
                                            style: subheading!
                                                .copyWith(color: blueColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "Submit Request",
                                                  style: buttontext!.copyWith(
                                                      color: whiteColor),
                                                ))),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
