import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:homedeals/utils/colors.dart';
import 'package:homedeals/utils/textTheams.dart';

class PropertyStatus extends StatefulWidget {
  const PropertyStatus({Key? key}) : super(key: key);

  @override
  State<PropertyStatus> createState() => _PropertyStatusState();
}

class _PropertyStatusState extends State<PropertyStatus> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      margin: EdgeInsets.symmetric(horizontal:screenWidth*0.1),
      width: screenWidth,
      height: 300,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Container(
                padding: EdgeInsets.only(top: 30,left: 5),
                width: screenWidth*0.15,
                height: screenHeight*0.1,
                child: AutoSizeText("Property Type",style: Theme.of(context).textTheme.bodyMedium,),
              ),
              Container(
                padding: EdgeInsets.only(top: 30,left: 5),
                width: screenWidth*0.15,
                height: screenHeight*0.1,
                child: AutoSizeText("Property Status",style: Theme.of(context).textTheme.bodyMedium,),
              ),
              Container(
                padding: EdgeInsets.only(top: 30,left: 5),
                width: screenWidth*0.15,
                height: screenHeight*0.1,
                child: AutoSizeText("Property Cities",style: Theme.of(context).textTheme.bodyMedium,),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: screenWidth*0.15,
                height: screenHeight*0.3,
                child: Row(
                  children: [
                    Container(
                      width: screenWidth*.1,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 20,
                          sections: showingSections(),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("data"),
                        Text("data"),
                        Text("data"),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: screenWidth*0.15,
                height: screenHeight*0.3,
                child: Row(
                  children: [
                    Container(
                      width: screenWidth*.1,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 20,
                          sections: showingSections(),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("data"),
                        Text("data"),
                        Text("data"),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: screenWidth*0.15,
                height: screenHeight*0.3,
                child: Row(
                  children: [
                    Container(
                      width: screenWidth*.1,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 20,
                          sections: showingSections(),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("data"),
                        Text("data"),
                        Text("data"),
                      ],
                    )
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 0)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue, // Replace with your color
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Replace with your color
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            showTitle: true,
            color: Colors.yellow, // Replace with your color
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Replace with your color
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple, // Replace with your color
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Replace with your color
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green, // Replace with your color
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Replace with your color
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
