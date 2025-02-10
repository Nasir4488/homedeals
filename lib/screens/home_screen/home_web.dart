import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:homedeals/screens/home_screen/wedgits/finestproperties.dart';
import 'package:homedeals/screens/home_screen/wedgits/resdensial_properties.dart';
import '../../utils/constants.dart';
import '../../wedgits/fotterSection.dart';
import 'wedgits/export_home_wedgits.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({Key? key}) : super(key: key);

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            HomeHeader(),
            DiscoverProperty(),
            SizedBox(height: 30,),
            ComercialProperties(),
            ResdensialProperties(),
            FinestProperties(),
            Fotter(),


          ],
        )
      ),
    );
  }
}
