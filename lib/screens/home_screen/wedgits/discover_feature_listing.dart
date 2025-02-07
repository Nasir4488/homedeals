import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:homedeals/cores/homeController.dart';
import 'package:homedeals/models/favorite_property.dart';
import 'package:homedeals/models/property_model.dart';
import 'package:homedeals/screens/single_property/wedgits/export.dart';
import 'package:homedeals/utils/colors.dart';
import 'package:homedeals/utils/routes.dart';

class DiscoverProperty extends StatefulWidget {
  @override
  State<DiscoverProperty> createState() => _DiscoverPropertyState();
}

class _DiscoverPropertyState extends State<DiscoverProperty> {
  var homeController = Get.put(HomeController());

  Future<List<Property>> _fetchProperties() async {
    await homeController.searchProperties({"isfeatured": true});
    return homeController.properties;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height * 0.9;
    var screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<List<Property>>(
      future: _fetchProperties(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while the data is being fetched
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // Show an error message if something went wrong
          return Center(
            child: Text("Error loading properties"),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Show a message if no data is found
          return Center(
            child: Text("No properties found"),
          );
        } else {
          // Render the UI with the data
          return Container(
            width: Get.width,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(),
                Text(
                  "Discover Our Featured Listings",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 5),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      letterSpacing: 1, fontWeight: FontWeight.w400, fontSize: 14),
                ),
                SizedBox(height: screenheight * 0.1),
                Center(
                  child: Container(
                    width: screenWidth * 0.9,
                    alignment: Alignment.center,
                    height: screenheight * 0.7,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 500,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1 / 3,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 8),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: snapshot.data!.map((property) {
                        return Builder(
                          builder: (context) {
                            return InkWell(
                              onTap: () async {
                                var box = Hive.box('propertyBox');
                                await box.put('selectedProperty', property);

                                // Navigate to the single property screen
                                // Get.toNamed(AllRoutes.singlePropertyScreen, arguments: property);
                              },
                              child: DiscoverListing(property: property),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          );
        }
      },
    );
  }
}

class DiscoverListing extends StatefulWidget {
  final Property property;

  DiscoverListing({Key? key, required this.property}) : super(key: key);

  @override
  State<DiscoverListing> createState() => _DiscoverListingState();
}

class _DiscoverListingState extends State<DiscoverListing> {
  bool isHovered = false;
  bool isFavorite = false;
  var homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

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
  Widget build(BuildContext context) {
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
      child: Container(
        height: Get.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(height: 10),
                GestureDetector(
                  child: Container(
                    width: Get.width,
                    height: Get.height * 0.35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.property.photos![0],
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.medium,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: Get.height * 0.25,
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
                  bottom: 20,
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
                          children: [
                            InkWell(
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: whiteColor,
                                  size: 14,
                                ),
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
                            InkWell(
                              onTap: (){
                                print(widget.property.photos![0]);
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: whiteColor,
                                  size: 14,
                                ),
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
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    "${widget.property.type}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 6),
                  Text(
                    "${widget.property.address}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("${widget.property.bedrooms}",
                          style: Theme.of(context).textTheme.bodySmall),
                      SizedBox(width: 1),
                      Icon(
                        Icons.bed_sharp,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${widget.property.bathrooms}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(width: 1),
                      Icon(
                        Icons.bathroom,
                        size: 16,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    "${widget.property.label}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 15),
                  Divider(),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.property.listingAgent.name}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        "${getPropertyAge(widget.property.yearBuilt)}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
}
