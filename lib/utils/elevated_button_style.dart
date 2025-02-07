import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
ElevatedButtonThemeData elevatedButton_style=ElevatedButtonThemeData(

  style: ElevatedButton.styleFrom(
    textStyle: GoogleFonts.poppins( // Apply Google Font to text
      fontSize: 14, // Adjust font size as needed
      fontWeight: FontWeight.w400, // Adjust font weight as needed
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0), // Adjust the border radius as needed
    ),
    padding: EdgeInsets.symmetric(vertical: 16.0), // Adjust the vertical padding as needed
    // backgroundColor:  Color(0xFFFF416A), // Set the background color to light blue
     backgroundColor:  Colors.red, // Set the background color to light blue
    // backgroundColor: Colors.lightBlue.shade400, // Set the background color to light blue
  ),
);



ButtonStyle elevatedButtonStyle_home({
  Color? backgroundColor,
  double? opacity,
  BorderRadius borderRadius = const BorderRadius.only(
    topRight: Radius.circular(6),
    topLeft: Radius.circular(6),
  ),
}) {
  return ElevatedButton.styleFrom(
    backgroundColor: backgroundColor != null
        ? backgroundColor.withOpacity(opacity ?? 1.0)
        : null,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius,
    ),
  );
}
