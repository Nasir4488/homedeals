import 'package:flutter/material.dart';

import '../../../utils/textTheams.dart';
class TypeDropDown extends StatefulWidget {
  final List<Map<String, dynamic>> menu; // Accepts submenus as well
  final String title;
  final ValueChanged<List<String>>? onItemSelected;

  TypeDropDown({required this.menu, required this.title, this.onItemSelected});

  @override
  _TypeDropDownState createState() => _TypeDropDownState();
}

class _TypeDropDownState extends State<TypeDropDown> {
  OverlayEntry? overlayEntry;
  OverlayEntry? nestedOverlayEntry;
  bool isDropdownOpen = false;
  bool isNestedOpen = false;
  bool isHoverednested=false;


  //

  String selected = "";
  ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose(); // ✅ Dispose controller to prevent memory leaks
    super.dispose();
  }
  void showDropdown(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
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
                    int index = widget.menu.indexOf(item);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HoverListTile(
                          title: item['title'],
                          hasSubmenu: item.containsKey('submenu'),
                          onTap: () {
                            if (!item.containsKey('submenu')) {
                              // saveProperty(item['title']);
                              // Get.toNamed(AllRoutes.shortFilterScreen, arguments: {"filterType": "type"});
                              hideDropdown();
                            }
                          },
                          onHover: (isHovering) {
                            if (isHovering && item.containsKey('submenu')) {
                              showNestedDropdown(context, item['submenu'], position.dx + 220, position.dy,item["title"]);
                            }
                          },
                        ),
                        if (index != widget.menu.length - 1) Divider(height: 1),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
    setState(() {
      isDropdownOpen = true;
    });
  }

  void showNestedDropdown(BuildContext context, List<String> submenu, double left, double top,String type) {
    hideNestedDropdown(); // Ensure only one nested menu opens at a time
    nestedOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: left, // Position next to main menu
        top: top + 40, // Adjust height
        width: 180,
        child: Material(
          color: Colors.transparent,
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 400,
              ),
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: submenu.map((subItem) {
                      return MouseRegion(
                        onEnter: (_){
                          setState(() {
                            isHoverednested= true;
                          });
                        },
                        onExit: (_){
                          setState(() {
                            isHoverednested= false;
                          });
                        },
                        child: ListTile(
                          title: Text(subItem,style: isHoverednested?navtext:textfieldtext,),
                          onTap: () {
                            selected =subItem;
                            setState(() {});
                            widget.onItemSelected!([selected,type]);
                            hideDropdown();
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

          ),
        ),
      ),
    );

    Overlay.of(context).insert(nestedOverlayEntry!);
    setState(() {
      isNestedOpen = true;
    });
  }

  void hideDropdown() {
    overlayEntry?.remove();
    overlayEntry = null;
    hideNestedDropdown();
    setState(() {
      isDropdownOpen = false;
    });
  }

  void hideNestedDropdown() {
    nestedOverlayEntry?.remove();
    nestedOverlayEntry = null;
    setState(() {
      isNestedOpen = false;
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
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selected == null || selected.isEmpty?widget.title:selected,
              style: subheading,
            ),
            Icon(Icons.keyboard_arrow_down)
          ],
        ),
      ),
    );
  }
}

class HoverListTile extends StatefulWidget {
  final String title;
  final bool hasSubmenu;
  final VoidCallback onTap;
  final ValueChanged<bool>? onHover;
  final String? selected;

  HoverListTile({
    required this.title,
    required this.onTap,
    this.hasSubmenu = false,
    this.onHover,
    this.selected,
  });

  @override
  _HoverListTileState createState() => _HoverListTileState();
}

class _HoverListTileState extends State<HoverListTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        if (widget.onHover != null) widget.onHover!(true);
      },
      onExit: (_) {
        setState(() => isHovered = false);
        if (widget.onHover != null) widget.onHover!(false);
      },
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: isHovered ? Colors.blue[100] : Colors.white,
        ),
        child: ListTile(
          title: Text( widget.title,style: isHovered?navtext:textfieldtext,),

          trailing: widget.hasSubmenu ? Icon(Icons.arrow_right, color: Colors.grey,) : null,
          tileColor: Colors.white,
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
