import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../utils/constanats.dart';
import '../../../utils/routes.dart';
import '../../../utils/textTheams.dart';
class ComercialProperties extends StatelessWidget {
  const ComercialProperties({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var screenheight=MediaQuery.of(context).size.height;
    var screenWidth=MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.only(left: screenWidth*0.1,right: screenWidth*0.1,top: 100),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          runSpacing: 20,
          spacing: 20,
          children: [
            for(var i=0;i<6;i++)
              Container(
                width: screenWidth/4,
                height: screenheight/3,
                child: i==0?Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText("Comercial",style: mediamheading!.copyWith(fontWeight: FontWeight.w600,fontSize: 30),),
                                SizedBox(height: 5,),
                                AutoSizeText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidi dunt",style: textsmall.copyWith()),
                              ],
                            )
                        ):CustomProperty(image: images[0],label: comercial[i],),
              )
          ],
        ),
      ),
    );
  }
}
class CustomProperty extends StatefulWidget {
  final String image;
  final String label;
  CustomProperty({Key? key,required this.image,required this.label}) : super(key: key);

  @override
  _CustomPropertyState createState() => _CustomPropertyState();
}

class _CustomPropertyState extends State<CustomProperty> {
  bool isHovered = false;
  Future<void> saveProperty(String type) async {
    var box = Hive.box('propertyBox');
    await box.put("propertyLabel", type);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: InkWell(
        onTap: (){
          Get.toNamed(AllRoutes.shortFilterScreen,);
          saveProperty(widget.label);
        },
        child: Stack(
          children: [
            // Background Image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.9),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Semi-transparent Dark Overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8)
                ),
                height: Get.height * 0.25,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: isHovered ? 0 : 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(1),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),


            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    "${widget.label}",
                    style: textmediam!.copyWith(color: Colors.white)
                  ),
                  Expanded(child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("More",style: TextStyle( color: Colors.white,)),

                        Icon(Icons.play_arrow,color:  Colors.white)
                      ],),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

