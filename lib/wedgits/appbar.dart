import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:homedeals/screens/short_filter/ShortFiltersScreen.dart';
import 'package:homedeals/utils/routes.dart';
import 'package:homedeals/utils/textTheams.dart';

import 'CustomDropdownMenu.dart';

Widget appBarForWeb(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  final List<String> menu =[
    "Residential",
    "Industrial estate",
    "Agricultural",
    "Apartment",
    "House",
    "Commercial",
  ];

  return Container(
    height: screenHeight * 0.12,
    width: screenWidth,
    color: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: screenWidth > 950 ? screenWidth * 0.1 : 0),
    child: Row(
      children: [
        _buildLogo(),
        Spacer(),
        NavItem(title: "Home", onTap:()=> Get.toNamed(AllRoutes.homePage)),
        SizedBox(width: 6),
        PropertiesDropDown(title: "Properties",list: menu,),
        SizedBox(width: 6),
        NavItem(title: "Advance Search", onTap: () => Get.toNamed(AllRoutes.advancefilter)),
        SizedBox(width: screenWidth * 0.05),
        NavItem(title: "Login", onTap: () => Get.toNamed(AllRoutes.profilescreen)),

        SizedBox(width: screenWidth * 0.02),
        _buildAddPropertyButton(screenWidth),
      ],
    ),
  );
}

Widget _buildLogo() {
  return InkWell(
    onTap: () => Get.toNamed(AllRoutes.homePage),
    child: Image.asset(
      "assets/images/logo.jpeg",
      fit: BoxFit.contain,
      height: MediaQuery.of(Get.context!).size.height * 0.08,
    ),
  );
}

class NavItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const NavItem({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  _NavItemState createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AutoSizeText(
            widget.title,
            style: navtext!.copyWith(color: isHovered ? Colors.blue : Colors.black),
          ),
        ),
      ),
    );
  }
}

Widget _buildAddPropertyButton(double screenWidth) {
  return SizedBox(
    width: screenWidth * 0.1,
    height: 50,
    child: ElevatedButton(
      onPressed: () => Get.toNamed(AllRoutes.createListingPage),
      child: AutoSizeText(
        'Add Property',
        style: navtext.copyWith(color: Colors.white),
      ),
    ),
  );
}

class PropertiesDropDown extends StatefulWidget {
  final String title;
  final List<String> list;

  PropertiesDropDown({
    required this.list,
    required this.title,
  });

  @override
  State<PropertiesDropDown> createState() => _PropertiesDropDownState();
}
class _PropertiesDropDownState extends State<PropertiesDropDown> {
  OverlayEntry? overlayEntry;
  bool isDropDownOpen = false;
  final ScrollController _scrollController = ScrollController();
  bool isHovered = false;

  Future<void> saveProperty(String label) async {
    var box = Hive.box('propertyBox');
    await box.put("propertyLabel", label);
  }
  void showDropDown(BuildContext context) {
    if (isDropDownOpen) return;
    hideDropDown();
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: hideDropDown,
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            top: position.dy + size.height,
            left: position.dx,
            width: 200,
            child: Material(
              color: Colors.white,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 400, // Max height, if the list is too long
                ),
                child: Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(widget.list.length, (index) {
                        return Column(
                          children: [
                            Card(
                              margin: EdgeInsets.zero,
                              elevation: 5,
                              child: HoverListTile(
                                title: widget.list[index],
                                  onTap: () async {
                                    saveProperty(widget.list[index]); // Ensure property is saved first
                                    hideDropDown();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => Shortfiltersscreen()),
                                          (Route<dynamic> route) => false,  // This removes all previous routes
                                    );


                                  }


                              ),
                            ),
                            // Add a Divider except for the last item
                            if (index != widget.list.length - 1)
                              Divider(height: 1, color: Colors.grey.shade100),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
    setState(() {
      isDropDownOpen = true;
    });
  }

  void hideDropDown() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
      setState(() {
        isDropDownOpen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_)async{
        setState(() {
          isHovered = true;
        });
      },

      onExit: (_){
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          if (isDropDownOpen) {
            hideDropDown();
          } else {
            showDropDown(context);
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(10),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: navtext!.copyWith(
                  color: isHovered?Colors.blue:Colors.black,

                ),
              ),

              Icon(Icons.keyboard_arrow_down,color: isHovered?Colors.blue:Colors.black,),
            ],
          ),
        ),
      ),
    );
  }
}
