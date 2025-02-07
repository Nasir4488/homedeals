import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:homedeals/utils/colors.dart';
import 'package:homedeals/utils/textTheams.dart';

class CustomCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<DateTime> dates = generateDates(15);

    return Container(
      margin: EdgeInsets.only(top: 15),
      height: 100, // Adjust the height according to your design
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          return InkWell(
            onTap: (){
              print(date);
            },
            child: Container(
              width: MediaQuery.of(context).size.width*0.2 / 3, // Display 3 dates on screen
              alignment: Alignment.center,
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: blueColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    "${date.day}",
                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: whiteColor)

            ),
                  AutoSizeText(
                    "${date.month}/${date.year}",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: whiteColor)
                  ),
                  AutoSizeText(getDayName(date.weekday),style: profileText!.copyWith(color: whiteColor),)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<DateTime> generateDates(int numberOfDays) {
    final List<DateTime> dates = [];
    final DateTime currentDate = DateTime.now();

    for (int i = 0; i < numberOfDays; i++) {
      dates.add(currentDate.add(Duration(days: i)));
    }
    return dates;
  }
}
String getDayName(int weekday) {
  switch (weekday) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default:
      return '';
  }
}
