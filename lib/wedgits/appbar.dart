import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/utils/colors.dart';
import 'package:homedeals/utils/routes.dart';
import 'package:homedeals/utils/textTheams.dart';

Widget appBarForWeb(BuildContext context) {
  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;

  Future<void> _loadImage() async {
    await Future.delayed(
        Duration(milliseconds: 10)); // Simulate image loading time
  }

  return Container(
    height: screenHeight * 0.12,
    width: screenWidth,
    color: Colors.white,
    child: Container(
      width: screenWidth,
      margin: Get.width > 950
          ? EdgeInsets.symmetric(horizontal: screenWidth * 0.1)
          : EdgeInsets.zero,
      child: Row(
        children: [
          // Logo
          Container(
            child: FutureBuilder(
              future: _loadImage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AllRoutes.homePage);
                    },
                    child: Container(
                      child: Image.asset(
                        "assets/images/logo.png",
                        color: Colors.black,
                        fit: BoxFit.contain,
                        height: MediaQuery.of(Get.context!).size.height * 0.03,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    color: Colors.grey[300], // Placeholder background color
                    child: Center(
                      child: CircularProgressIndicator(), // Loading indicator
                    ),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildNavItem("Home", context, () {
                  Get.toNamed(AllRoutes.homePage);
                }, false),
                SizedBox(width: 6),
                CustomDropdownMenu(),

                _buildNavItem("Advance Search", context, () {
                  Get.toNamed(AllRoutes.advancefilter);
                }, false),
                // DropDownButton(),
                SizedBox(width: 6),
                // Add more navigation options here
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.person_pin,
              color: Colors.black,
            ),
            onPressed: () async {
              Get.toNamed(AllRoutes.profilescreen);
              // Get.toNamed(AllRoutes.loginPage);
              // Handle profile icon press
            },
          ),
          SizedBox(width: screenWidth * 0.05),
          // Create Listing Button
          Container(
            width: screenWidth * 0.1,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(AllRoutes.createListingPage);
              },
              child: AutoSizeText(
                'Add Property',
                style: navtext.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          // SizedBox(width: screenWidth * 0.01),
        ],
      ),
    ),
  );
}

class NavItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool hasIcon;

  NavItem({required this.title, required this.onTap, this.hasIcon = false});

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
      child: InkWell(
        hoverColor: Colors.transparent, // Prevent default hover color
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              AutoSizeText(
                widget.title,
                style: navtext.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isHovered ? Colors.blue : Colors.black),
              ),
              SizedBox(width: 6),
              widget.hasIcon
                  ? Icon(
                      Icons.keyboard_arrow_down,
                      color: isHovered ? Colors.blue : Colors.black,
                      size: Get.width > 800 ? 16 : 12,
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildNavItem(
    String title, BuildContext context, VoidCallback ontab, bool icon) {
  return NavItem(title: title, onTap: ontab, hasIcon: icon);
}

class HoverableNavItem extends StatefulWidget {
  final String title;
  final List<PopupMenuEntry<Object>> items;

  HoverableNavItem({required this.title, required this.items});

  @override
  _HoverableNavItemState createState() => _HoverableNavItemState();
}

class _HoverableNavItemState extends State<HoverableNavItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: PopupMenuButton<Object>(
        child: Row(
          children: [
            Text(widget.title,
                style: mediamheading!.copyWith(
                  color: isHovered ? Colors.blue : Colors.black,
                )
                // color: isHovered ? Colors.blue : Colors.black,

                ),
            Icon(
              Icons.keyboard_arrow_down,
              color: isHovered ? Colors.blue : Colors.black,
            ),
          ],
        ),
        itemBuilder: (BuildContext context) {
          return widget.items.map((item) {
            if (item is PopupMenuItem<Object>) {
              return PopupMenuItem<Object>(
                child: item.child!,
              );
            }
            return item;
          }).toList();
        },
      ),
    );
  }
}

class CustomDropdownMenu extends StatefulWidget {
  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool isDropdownOpen = false;
  bool isHoverd = false;

  final List<String> menuItems = [
    'Residenctial Properties',
    'Commercial Properties',
    'HOUSES',
    'VILLA',
    'PROPERTY LAYOUT V5',
  ];

  void _toggleDropdown() {
    if (isDropdownOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      isDropdownOpen = false;
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)!.insert(_overlayEntry!);
      isDropdownOpen = true;
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              // Close the dropdown if user taps outside
              _toggleDropdown();
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            width: 250, // Adjust width based on your need
            height: 300,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: Offset(0, 40), // Adjust the position of the dropdown
              child: Visibility(
                visible: isDropdownOpen,
                child: Material(
                  shadowColor: Colors.grey,
                  elevation: 1000,
                  color: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: menuItems.length,
                      itemBuilder: (context, index) {
                        return HoverableMenuItem(
                          text: menuItems[index],
                          onTap: () {
                            print('${menuItems[index]} selected');
                            _toggleDropdown(); // Close dropdown on selection
                          },
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
        link: _layerLink,
        child: GestureDetector(
            onTap: _toggleDropdown,
            child: MouseRegion(
              onEnter: (_) => setState(() => isHoverd = true),
              onExit: (_) => setState(() => isHoverd = false),
              child: Container(
                padding: EdgeInsets.all(8),
                child: InkWell(
                  onTap: _toggleDropdown,
                  child: Row(
                    children: [
                      Text(
                        'Properties',
                        style: navtext.copyWith(
                            fontWeight: FontWeight.w500,
                            color: isHoverd ? Colors.blue : Colors.black),
                      ),
                      Icon(Icons.keyboard_arrow_down,color: isHoverd ? Colors.blue : Colors.black,),
                    ],
                  ),
                ),
              ),
              // child: Container(
              //   padding: EdgeInsets.all(8),
              //   child: Row(
              //     children: [
              //       Text('PROPERTY LAYOUT'),
              //       Icon(Icons.keyboard_arrow_down),
              //     ],
              //   ),
              // ),
            )));
  }
}

class HoverableMenuItem extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  HoverableMenuItem({required this.text, required this.onTap});

  @override
  _HoverableMenuItemState createState() => _HoverableMenuItemState();
}

class _HoverableMenuItemState extends State<HoverableMenuItem> {
  bool isHovered = false;

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
        color: isHovered ? Colors.blue.withOpacity(0.2) : Colors.transparent,
        child: ListTile(
          title: Text(
            widget.text,
            style: navtext.copyWith(
              fontWeight: FontWeight.w500,
              color: isHovered ? Colors.blue : Colors.black,
            ),
          ),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
