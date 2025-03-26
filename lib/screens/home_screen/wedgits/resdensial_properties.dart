import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:homedeals/utils/routes.dart';
import '../../../utils/constants.dart';
import '../../../utils/textTheams.dart';
class ResdensialProperties extends StatelessWidget {
  const ResdensialProperties({
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
        margin: EdgeInsets.symmetric(horizontal: screenWidth*0.1,vertical: 80),
        child:  Wrap(
          alignment: WrapAlignment.spaceEvenly,
          runSpacing: 20,
          spacing: 20,
          children: [
            for(var i=0;i<3;i++)
              Container(
                width: screenWidth/4,
                height: screenheight/3,
                child: i==0?Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText("Resdencial",style: mediamheading!.copyWith(fontWeight: FontWeight.w600,fontSize: 30),),
                        SizedBox(height: 5,),
                        AutoSizeText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidi dunt",style: textsmall.copyWith()),
                      ],
                    )
                ):CustomProperty(imgUrl: images[0],label: residenctial[i],),
              )
          ],
        ),
      ),
    );
  }
}

class CustomProperty extends StatefulWidget {
  final String imgUrl;
  final int? results;
  final String? label;

  CustomProperty({Key? key,required this.imgUrl,this.results,this.label}) : super(key: key);

  @override
  _CustomPropertyState createState() => _CustomPropertyState();
}

class _CustomPropertyState extends State<CustomProperty> {
  bool isHovered = false;
  Future<void> saveProperty(String label) async {
    var box = Hive.box('propertyBox');
    await box.put("propertyLabel", label);
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
        onTap: ()async{
          await saveProperty(widget.label!);
          Get.toNamed(AllRoutes.shortFilterScreen,);

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
                  image: AssetImage(widget.imgUrl),
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
                    style: TextStyle(
                      color:  Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(child: Container(
                    alignment: Alignment.bottomCenter,
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

