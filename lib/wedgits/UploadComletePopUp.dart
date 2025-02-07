import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/routes.dart';

void showDialog({required BuildContext context, required AlertDialog Function(BuildContext context) builder}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Upload Complete"),
        content: Text("The images have been uploaded. Do you want to stay on this page or go to the home page?"),
        actions: <Widget>[
          TextButton(
            child: Text("Stay"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text("Go to Home Page"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              Get.toNamed(AllRoutes.createListingPage); // Navigate to the home page
            },
          ),
        ],
      );
    },
  );
}
