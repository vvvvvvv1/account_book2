import 'package:account_book2/BottomPage/SecondPage.dart';
import 'package:account_book2/Widget/TotalMoney.dart';
import 'package:account_book2/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// 두번째 탭
class Secondtab extends StatelessWidget {
  const Secondtab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TotalMoney(),
        Expanded(
          child: Container(
            color: Colors.white,
            child: TableCalendar(
              daysOfWeekHeight: 20,
              daysOfWeekStyle: const DaysOfWeekStyle(),
              locale: 'ko_KR',
              headerVisible: false,
              focusedDay: MainSelectDateTime,
              firstDay: DateTime.utc(1900, 1, 1),
              lastDay: DateTime.utc(2100, 1, 1),
              headerStyle: HeaderStyle(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
              ),
              calendarStyle: const CalendarStyle(
                weekendTextStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
                cellMargin: EdgeInsets.all(8),
                defaultTextStyle: TextStyle(
                  fontSize: 12,
                ),
                todayTextStyle: TextStyle(
                  fontSize: 12,
                ),
                tableBorder: TableBorder(
                  horizontalInside: BorderSide(
                    color: Colors.grey,
                  ),
                  verticalInside: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
