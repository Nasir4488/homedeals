import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/textTheams.dart';

Widget buildTextField(double screenWidth, String hint, TextEditingController controller,BuildContext context) {
  return Container(
    alignment: Alignment.center,
    width: screenWidth * 0.12,
    height: 40,
    child: Container(
      height: 40,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        cursorColor: Colors.grey.shade500,
        style: textfieldtext,
        decoration: textFieldDecoration(context: context, hint: hint),
      ),
    ),
  );
}