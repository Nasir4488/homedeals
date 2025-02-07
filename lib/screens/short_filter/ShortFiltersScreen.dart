import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/wedgits/appbar.dart';

import '../../cores/shortFilterController.dart';
import '../../models/property_model.dart';
import '../../utils/colors.dart';
import '../../utils/textTheams.dart';

class Shortfiltersscreen extends StatefulWidget {
  const Shortfiltersscreen({Key? key}) : super(key: key);

  @override
  State<Shortfiltersscreen> createState() => _ShortfiltersscreenState();
}

class _ShortfiltersscreenState extends State<Shortfiltersscreen> {
  var shortFilters = Get.put(ShortFilterController());
  Map<String, dynamic> filters = {};
  String filter=Get.arguments['filter']??'';
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: [
          appBarForWeb(context),
          Container(
            color: Colors.white.withOpacity(0.5),
            margin: EdgeInsets.symmetric(vertical: 20),
            width: screenWidth,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                FutureBuilder(
                    future: shortFilters.searchProperties({"label": "${filter}"}),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("Error"),
                        );
                      } else {
                        return Wrap(
                          spacing: 30.0, // Horizontal space between items
                          runSpacing: 30.0, // Vertical space between lines
                          children: [
                            for (var property in snapshot.data!)
                              Container(
                                  width: screenWidth / 4,
                                  child: CustomProperty(
                                    property: property,
                                  )),
                          ],
                        );
                      }
                    }),
                SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomProperty extends StatefulWidget {
  final Property property;

  const CustomProperty({Key? key, required this.property}) : super(key: key);

  @override
  _CustomPropertyState createState() => _CustomPropertyState();
}

class _CustomPropertyState extends State<CustomProperty> {
  bool isHovered = false;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
        width: double.infinity, // Ensures full width in the Wrap
        height: 300, // Fixed height for the property container
        child: Stack(
          fit: StackFit.expand,
          children: [
// Background Image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.property.photos![0],
                    fit: BoxFit.fill,
                  )),
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: isHovered ? 0 : 0.5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(1), Colors.transparent],
                  ),
                ),
              ),
            ),
// Content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
// Container(
//   height: 20,
//   width: 70,
//   decoration: BoxDecoration(
//     color: Colors.lightGreen.withOpacity(1),
//     borderRadius: BorderRadius.circular(6),
//   ),
//   child: Center(
//     child: Text(
//       '',
//       style: Theme.of(context).textTheme.bodySmall,
//     ),
//   ),
// ),
                    SizedBox(height: 10),
                    // Added spacing between 'Featured' and other content
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 25,
                          child: Center(
                            child: Text(
                              '${widget.property.status}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    AutoSizeText(
                      "${widget.property.title}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: whiteColor),
                    ),
                    SizedBox(height: 4),
                    AutoSizeText(
                      "\$${widget.property.price.toString()}",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600, color: whiteColor),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.bed_outlined, color: Colors.white, size: 16),
                        SizedBox(width: 2),
                        Text(
                          "${widget.property.bedrooms.toString()}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.shower_outlined,
                            color: Colors.white, size: 16),
                        SizedBox(width: 2),
                        Text(
                          "${widget.property.bathrooms}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.car_crash, color: Colors.white, size: 16),
                        SizedBox(width: 2),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget customColum(BuildContext context) {
  return AnimatedContainer(
    duration: Duration(seconds: 1),
    curve: Curves.easeInOut,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Ensure proper alignment
      children: [
        Text("Residential", style: mediamheading),
        SizedBox(height: 10), // Added spacing between text and description
        Container(
          height: Get.height * 0.15,
          width: Get.width * 0.2,
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            maxLines: 3,
            overflow: TextOverflow.ellipsis, // Added overflow handling
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        SizedBox(height: 10), // Added spacing before divider
        Container(
          height: 10,
          width: Get.width * 0.17,
          child: Divider(
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
