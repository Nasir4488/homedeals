import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../cores/homeController.dart';
import '../../../utils/colors.dart';
import '../../../utils/textTheams.dart';

Widget StatusButtons(String statusLabel, int active, BuildContext context) {
  HomeController homeController = Get.find<HomeController>();

  return InkWell(
    onTap: () {
      homeController.filterButton(active, statusLabel); // Update active filter\
    },
    child: Obx(() => Container(
      alignment: Alignment.center,
      width: 150,
      decoration: BoxDecoration(
        color: homeController.active == active
            ? Colors.white
            : Colors.blue.shade500.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      height: 50,
      child: AutoSizeText(
        statusLabel, // Use dynamic status label
        style: buttontext.copyWith(
          color:
          homeController.active == active ? Colors.black : whiteColor,
        ),
      ),
    )),
  );
}