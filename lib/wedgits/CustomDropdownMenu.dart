import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:homedeals/utils/textTheams.dart';

import '../utils/routes.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<String> menu;
  final String title;
  CustomDropdownMenu({required this.menu, required this.title});
  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  OverlayEntry? overlayEntry;
  bool isDropdownOpen = false;
  Future<void> saveProperty(String type) async {
    var box = Hive.box('propertyBox');
    await box.put("propertyType", type);
  }

  void showDropdown(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Tap outside to close the dropdown
          GestureDetector(
            onTap: hideDropdown,
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            left: position.dx,
            top: position.dy + size.height,
            width: 220,
            child: Material(
              color: Colors.transparent,
              child: Card(
                margin: EdgeInsets.zero,
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.menu.map((item) {
                    int index = widget.menu.indexOf(item); // Get the index
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HoverListTile(
                          title: item,
                          onTap: () {
                            saveProperty(item);
                            Get.toNamed(AllRoutes.shortFilterScreen, arguments: {"filterType": "type"});
                            hideDropdown();
                          },
                        ),
                        if (index != widget.menu.length - 1) Divider(height: 1,), // Add divider except for the last item
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          )


        ],
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
    setState(() {
      isDropdownOpen = true;
    });
  }

  void hideDropdown() {
    overlayEntry?.remove();
    overlayEntry = null;
    setState(() {
      isDropdownOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isDropdownOpen) {
          hideDropdown();
        } else {
          showDropdown(context);
        }
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          "Properties",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
class HoverListTile extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  HoverListTile({required this.title, required this.onTap});

  @override
  _HoverListTileState createState() => _HoverListTileState();
}

class _HoverListTileState extends State<HoverListTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(

        width: 550, // Adjust the width as needed
        decoration: BoxDecoration(
          color: isHovered ? Colors.blue[100] : Colors.white,
        ),
        child: ListTile(
          title: Text(widget.title, style: isHovered?navtext:textfieldtext,),
          tileColor:  Colors.white,
          onTap: widget.onTap,


        ),
      ),
    );
  }
}
