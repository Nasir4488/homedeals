import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:homedeals/cores/homeController.dart';
import 'package:homedeals/models/property_model.dart';
import 'package:homedeals/utils/routes.dart';

import '../../../models/favorite_property.dart';
import '../../../utils/colors.dart';
import '../single_property_screen.dart';

class Relatedproperties extends StatefulWidget {
  final Property property;

  const Relatedproperties({Key? key,required this.property}) : super(key: key);

  @override
  State<Relatedproperties> createState() => _RelatedpropertiesState();
}

class _RelatedpropertiesState extends State<Relatedproperties> {
  bool isHovered = false;
  bool isFavorite = false;
  var homeController = Get.put(HomeController());
  Future<void> _loadFavoriteStatus() async {
    bool favoriteStatus = await getFavoriteProperties();
    setState(() {
      isFavorite = favoriteStatus;
    });
  }
  Future<bool> getFavoriteProperties() async {
    List<Property> favProperties = await homeController.getFavProperties(widget.property.userId,);
    return favProperties.any((favProperty) => favProperty.id == widget.property.id);
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFavoriteStatus();
}
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    var propertyStatus=widget.property.status;
    var propertyType=widget.property.type;
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: InkWell(
        onTap: (){
          var box = Hive.box('propertyBox');
          box.put('selectedProperty', null);
             box.put('selectedProperty', widget.property);
            print(widget.property.title);
            setState(() {
            });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SinglePropertyScreen() ),
                (Route<dynamic> route) => false,
          );
        },
        child: Container(
          height: 400,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 2,
                offset: Offset(0, 2),
                spreadRadius: 2
              )
            ],
            color: whiteColor,
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.all(8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      child: Container(
                        width: screenwidth,
                        height: screenheight * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                          child: CachedNetworkImage(
                              imageUrl: widget.property.photos![0],
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          button_property(
                              title: widget.property.type,
                              color: Colors.green.shade900,
                              onpress: () {}),
                          button_property(
                              title: widget.property.label,
                              color: blackColor,
                              onpress: () {}),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: screenheight * 0.25,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 200),
                          opacity: isHovered ? 0 : 0.5,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(1),
                                  Colors.transparent
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20, // Adjusted position
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${widget.property.price}',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                prpertyIcons(
                                  icon: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                                SizedBox(width: 2),
                                InkWell(
                                  onTap: () async {
                                    // Toggle favorite status
                                    if (isFavorite) {
                                      homeController.removeFavorite(Favorite(userId: widget.property.userId, propertyId: widget.property.id.toString()));
                                      setState(() {
                                      });
                                    } else {
                                      homeController.addFavorite(Favorite(userId: widget.property.userId, propertyId: widget.property.id.toString()));
                                      setState(() {
                                      });
                                    }
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: isFavorite
                                          ? blueColor
                                          : Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Image.asset(
                                      "assets/icons/heart.png",
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2),
                                prpertyIcons(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                                SizedBox(width: 2),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.property.title,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        widget.property.address,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(widget.property.bedrooms.toString(),
                              style: Theme.of(context).textTheme.bodySmall),
                          SizedBox(
                            width: 1,
                          ),
                          Icon(
                            Icons.bed_sharp,
                            size: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.property.bathrooms.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Icon(
                            Icons.bathroom_outlined,
                            size: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        widget.property.type,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Container(
                        color: greyColor,
                        width: screenwidth,
                        height: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.property.listingAgent.name,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),Text(
                            getPropertyAge(widget.property.yearBuilt),

                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
Widget prpertyIcons({required Icon icon}) {
  return Container(
    height: 25,
    width: 25,
    decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(5)),
    child: icon,
  );
}
String getPropertyAge(DateTime? yearBuilt) {
  if (yearBuilt == null) {
    return "Unknown";
  }
  final currentDate = DateTime.now();
  final difference = currentDate.difference(yearBuilt);

  final years = (difference.inDays / 365).floor();
  final months = ((difference.inDays % 365) / 30).floor();
  final days = (difference.inDays % 365) % 30;

  List<String> ageParts = [];

  if (years > 0) {
    ageParts.add("$years year${years > 1 ? 's' : ''}");
  }

  if (months > 0) {
    ageParts.add("$months month${months > 1 ? 's' : ''}");
  }

  if (days > 0) {
    ageParts.add("$days day${days > 1 ? 's' : ''}");
  }

  return ageParts.isNotEmpty ? ageParts.join(', ') : "Less than a day old";
}
