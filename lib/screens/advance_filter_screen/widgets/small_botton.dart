import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget button_property(
    {required String title, required Color color, onpress()?}) {
  return Container(
    padding: EdgeInsets.all(6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      color: color.withOpacity(0.7),
    ),
    child: Container(
      alignment: Alignment.center,
      child: Text(
        title,
        style: GoogleFonts.poppins(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),
      ),
    ),
  );
}


