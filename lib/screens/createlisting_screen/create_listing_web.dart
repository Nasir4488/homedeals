import 'package:flutter/material.dart';
import 'package:homedeals/utils/colors.dart';
import 'wedgits/exprot_create_listing.dart';
class CreateListingWeb extends StatefulWidget {
  const CreateListingWeb({Key? key}) : super(key: key);
  @override
  State<CreateListingWeb> createState() => _CreateListingState();
}

class _CreateListingState extends State<CreateListingWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenbackgroundColor,
      body: ListView(
        shrinkWrap: true,
        children: [
          Appbar(),
          Description(),
          MediaSection(),
          Details(),
          Features(),
          Location(),
          // DescriptionText(),
        ],
      ),
    );
  }
}



