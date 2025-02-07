import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
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
        margin: EdgeInsets.symmetric(horizontal: screenWidth*0.14,vertical: 50),
        child: StaggeredGrid.count(
          crossAxisCount: 6,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          children:  [
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1.5,
              child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText("Residential",style: mediamheading,),
                      AutoSizeText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidi dunt",style: Theme.of(context).textTheme.bodySmall!.copyWith()),
                    ],
                  )
              ),
            ),

            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1.5,
              child: CustomProperty(imgUrl: images[3],title: residenctial[0],),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1.5,
              child: CustomProperty(imgUrl: images[3],title: residenctial[1],),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1.5,
              child: CustomProperty(imgUrl: images[3],title: residenctial[2],),
            ),

          ],
        ),
      ),
    );
  }
}







class CustomProperty extends StatefulWidget {
  final String imgUrl;
  final int? results;
  final String? title;

  CustomProperty({Key? key,required this.imgUrl,this.results,this.title}) : super(key: key);

  @override
  _CustomPropertyState createState() => _CustomPropertyState();
}

class _CustomPropertyState extends State<CustomProperty> {
  bool isHovered = false;

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
          Get.toNamed(AllRoutes.shortFilterScreen, arguments: {"filter": "${widget.title}"});
          print(widget.title);
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
                    "${widget.title}",
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

Widget customColum() {
  return AnimatedContainer(
    duration: Duration(seconds: 1),
    curve: Curves.easeInOut,
    child: Column(
      children: [
        Text("Residential",),
        Container(
          height: Get.height * 0.15,
          width: Get.width * 0.2,
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidi dunt",
            maxLines: 3,
          ),
        ),
        Container(
          height: 10,
          width: Get.width * 0.17,
          child: Divider(
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
