import 'package:flutter/material.dart';

import '../utils/textTheams.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<String> menu;
  final String title;
  final TextStyle? textstyle;

  @override
  CustomDropdownMenu({required this.menu,required this.title,this.textstyle});
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: PopupMenuButton<String>(
        onSelected: (value) => print('$value selected'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: navtext.copyWith(
                color: isHovered ? Colors.blueAccent : Colors.black,
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: isHovered ? Colors.blue : Colors.black),
          ],
        ),
        itemBuilder: (context) => widget.menu
            .map((item) => PopupMenuItem(
          value: item,
          child: Text(item, style: navtext),
        ))
            .toList(),
      ),
    );
  }
}
