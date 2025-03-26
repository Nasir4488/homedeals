import 'package:flutter/material.dart';

import '../../../utils/textTheams.dart';
import '../../../wedgits/CustomDropdownMenu.dart';
class CustomIntDropDown extends StatefulWidget {
  final String title;
  final List<String> list;
  final List<String>? flist;
  final String? header;
  final ValueChanged<String>? onItemSelected;
  final ValueChanged<String>? onItemFSelected;


  CustomIntDropDown(
      {required this.list,
        required this.title,
        this.onItemSelected,
        this.onItemFSelected,
        this.header,
        this.flist});

  @override
  State<CustomIntDropDown> createState() => _CustomIntDropDownState();
}

class _CustomIntDropDownState extends State<CustomIntDropDown> {
  OverlayEntry? overlayEntry;
  bool isDropDownOpen = false;
  String? selectedItem;
  final ScrollController _scrollController = ScrollController();

  TextEditingController iPrice = TextEditingController();
  TextEditingController fPrice = TextEditingController();

  void showDropDown(BuildContext context) {
    hideDropDown();
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: hideDropDown,
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            top: position.dy + size.height,
            left: position.dx,
            width: widget.title=="Bedrooms"?200:240,
            child: Material(
              color: Colors.white,
              child: Container(
                height: 290,
                child: ListView(
                  children: [
                    Visibility(
                      visible: (widget.flist != null && widget.flist!.isNotEmpty),
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                child: TextField(
                                  controller: iPrice,
                                  style: TextStyle(fontSize: 12),
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(fontSize: 12,overflow: TextOverflow.ellipsis),
                                    hintText: iPrice.text.isEmpty ? "First Price" : iPrice.text,
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.shade500),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                child: TextField(
                                  controller: fPrice,
                                  style: TextStyle(fontSize: 12),
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(fontSize: 12,overflow: TextOverflow.ellipsis),
                                    hintText: iPrice.text.isEmpty ? "Last Price" : iPrice.text,
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.shade500),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // List Items
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...widget.list.map((item) {
                          // If flist is empty, just display item from list
                          if (widget.flist?.isEmpty ?? true) {
                            return Card(
                              margin: EdgeInsets.zero,
                              elevation: 5,
                              child: HoverListTile(
                                title: item,
                                onTap: () {
                                  setState(() {
                                    selectedItem = item;
                                  });
                                  widget.onItemSelected?.call(item);
                                  hideDropDown();
                                },
                              ),
                            );
                          } else {
                            // If flist is not empty, display both list and flist items in a Row
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // HoverListTile from widget.list
                                Card(
                                  shadowColor: Colors.transparent,
                                  margin: EdgeInsets.zero,
                                  elevation: 5,
                                  child: Container(
                                    width: 110,
                                    child: HoverListTile(
                                      title: item,
                                      onTap: () {
                                        setState(() {
                                          // selectedItem = item;
                                          iPrice.text=item;
                                        });
                                        widget.onItemSelected?.call(item);
                                        if(iPrice.text==">0"){
                                          hideDropDown();
                                        }


                                      },
                                    ),
                                  ),
                                ),

                                // HoverListTile from widget.flist (or empty if flist is shorter)
                                if (widget.flist!.length > widget.list.indexOf(item))
                                  Card(
                                    shadowColor: Colors.transparent,
                                    margin: EdgeInsets.zero,
                                    elevation: 5,
                                    child: Container(
                                      width: 110,
                                      child: HoverListTile(
                                        title: widget.flist![widget.list.indexOf(item)],
                                        onTap: () {
                                          setState(() {
                                            String finalPrice = widget.flist![widget.list.indexOf(item)];
                                            fPrice.text = finalPrice;

                                          });
                                          selectedItem =fPrice.text=='>0'?'Price':"${iPrice.text} - ${fPrice.text}";
                                          widget.onItemFSelected?.call(widget.flist![widget.list.indexOf(item)]);

                                          hideDropDown();

                                        },
                                      ),
                                    ),
                                  )
                                else
                                  SizedBox.shrink(),  // If no corresponding item in flist, show nothing
                              ],
                            );
                          }
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
    setState(() {
      isDropDownOpen = true;
    });
  }

  void hideDropDown() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
      setState(() {
        isDropDownOpen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isDropDownOpen) {
          hideDropDown();
        } else {
          showDropDown(context);
        }
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedItem == ">0"
                  ? (widget.header == "bedroom" ? "Any Bedroom" : "Any Price")
                  : (selectedItem?.toString() ?? widget.title),
              style: subheading,
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}