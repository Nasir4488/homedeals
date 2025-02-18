import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/utils/routes.dart';
import 'package:homedeals/utils/textTheams.dart';

import 'CustomDropdownMenu.dart';

Widget appBarForWeb(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  final List<String> menu =[
  'Residential Properties',
  'Commercial Properties',
  'Houses',
  'Villa',
  'Property Layout V5',
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
        _buildNavItem("Home", () => Get.toNamed(AllRoutes.homePage)),
        SizedBox(width: 6),
        CustomDropdownMenu(menu:menu,title: "Properties",),
        SizedBox(width: 6),
        _buildNavItem("Advance Search", () => Get.toNamed(AllRoutes.advancefilter)),
        SizedBox(width: screenWidth * 0.05),
        IconButton(
          icon: const Icon(Icons.person_pin, color: Colors.black),
          onPressed: () => Get.toNamed(AllRoutes.profilescreen),
        ),
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
      "assets/images/logo.png",
      color: Colors.black,
      fit: BoxFit.contain,
      height: MediaQuery.of(Get.context!).size.height * 0.03,
    ),
  );
}

Widget _buildNavItem(String title, VoidCallback onTap) {
  return MouseRegion(
    onEnter: (_) => {},
    onExit: (_) => {},
    child: GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: AutoSizeText(
          title,
          style: navtext.copyWith(fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
    ),
  );
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

