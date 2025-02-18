import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
TextStyle textmediam = GoogleFonts.roboto(
  fontSize: 17,
  fontWeight: FontWeight.w400,
);

TextStyle textlarge = GoogleFonts.roboto(
  fontSize: 40,
  fontWeight: FontWeight.w300,
);


TextStyle textsmall = GoogleFonts.roboto(
  fontSize: 12,
  fontWeight: FontWeight.w300,
);
TextStyle buttontext = GoogleFonts.roboto(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);
TextStyle mediamheading = GoogleFonts.roboto(
  fontSize: 28,
  fontWeight: FontWeight.w400,
);
TextStyle textfieldtext = GoogleFonts.roboto(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);
TextStyle navtext = GoogleFonts.roboto(
  fontSize: 17,
  fontWeight: FontWeight.w400,
);
TextStyle subheading = GoogleFonts.roboto(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);TextStyle profileText = GoogleFonts.roboto(
  fontSize: 15,
  fontWeight: FontWeight.w200,
);

InputDecoration textFieldDecoration({
  BuildContext? context,
  String? label,
  String? hint,
  Icon? icon,
}) {
  return InputDecoration(
    suffixIcon: icon,
    suffixStyle: Theme.of(context!).textTheme.bodySmall!.copyWith(color: Colors.white),
    hintText: hint,
    alignLabelWithHint: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black, fontSize: 12),
    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Adjust padding to center text
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade500),
      borderRadius: BorderRadius.circular(7),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade500),
      borderRadius: BorderRadius.circular(7),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade500),
      borderRadius: BorderRadius.circular(7),
    ),

  );
}
