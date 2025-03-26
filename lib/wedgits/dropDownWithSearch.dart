import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homedeals/utils/textTheams.dart';

import '../cores/countryController.dart';

class DropdownWithSearch extends StatefulWidget {
  final String title;
  final List<String> list;
  final ValueChanged<String>? onItemSelected;
  final List<String>? flags;

  DropdownWithSearch({
    required this.list,
    required this.title,
    required this.onItemSelected,
    this.flags,
  });

  @override
  _DropdownWithSearchState createState() => _DropdownWithSearchState();
}

class _DropdownWithSearchState extends State<DropdownWithSearch> {
  String? selectedItem;
  var countryController = Get.put(CountryController());


  void _showPopup(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    showDialog(
      context: context,
      barrierColor: Colors.transparent, // No background overlay
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              top: position.dy + size.height, // Position dropdown below button
              left: position.dx,
              width: size.width*1.2, // Match width of button
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: SearchableDropdown(
                  flags: widget.flags ?? [],
                  list: widget.list,
                  onItemSelected:(selected) {
                    setState(() {
                      selectedItem = selected;
                    });
                    widget.onItemSelected?.call(selected);
                  },

                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _showPopup(context);
        print(countryController.cities);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedItem ?? widget.title,
              style: subheading,
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}

class SearchableDropdown extends StatefulWidget {
  final List<String> list;
  final List<String>? flags;
  final ValueChanged<String> onItemSelected;


  SearchableDropdown({required this.list,this.flags,required this.onItemSelected,});

  @override
  _SearchableDropdownState createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  TextEditingController _searchController = TextEditingController();
  List<String> filteredList = [];
  int hoveredIndex = -1; // Track hovered item
  List<String> flags=[];
  var countryController = Get.put(CountryController());

  @override
  void initState() {
    super.initState();
    filteredList = widget.list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      constraints: BoxConstraints(maxHeight: 300), // Limit dropdown height
      decoration: BoxDecoration(
        color: Colors.white, // Custom background color
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Search Field
          TextField(
            style: textfieldtext,
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search country...",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (value) {
              setState(() {
                filteredList = widget.list
                    .where((item) => item.toLowerCase().contains(value.toLowerCase()))
                    .toList();
              });
            },
          ),
          SizedBox(height: 10),
          // List of Countries with Hover Effect and Dividers
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: filteredList.length,
              separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey), // Divider
              itemBuilder: (context, index) {
                int originalIndex = widget.list.indexOf(filteredList[index]);
                return MouseRegion(
                  onEnter: (_) => setState(() => hoveredIndex = index),
                  onExit: (_) => setState(() => hoveredIndex = -1),
                  child: Container(
                    color: hoveredIndex == index ? Colors.blue[100] : Colors.transparent, // Hover effect
                    child: ListTile(
                      // leading: Text(widget.flags[originalIndex]),
                      title: Text(filteredList[index], style: textfieldtext),
                      onTap: () {
                        widget.onItemSelected(filteredList[index]);
                        Navigator.pop(context);
                        setState(() {
                        });

                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
