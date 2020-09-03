library pageview_calendar;

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'calendar.dart';

class PageViewCalendar extends StatelessWidget {
  StreamController<String> _monhtsLabel;
  PageController _pageController;
  List<String> daysOfWeek2 = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];

  DateTime _getSelectedDate(int idx, int initialPage, DateTime baseDateTime) {
    int realIndex = idx - initialPage;
    int calcIndex = (realIndex < 0) ? realIndex * -1 : realIndex;
    int monthsBump = calcIndex % 12;
    int yearsBump = calcIndex ~/ 12;

    return (realIndex < 0)
        ? DateTime((baseDateTime.year - yearsBump),
            (baseDateTime.month - monthsBump), baseDateTime.day)
        : DateTime((baseDateTime.year + yearsBump),
            (baseDateTime.month + monthsBump), baseDateTime.day);
  }

  void _updateMonthStream(DateTime dateTime) {
    _monhtsLabel.add(new DateFormat('yMMMM').format(dateTime));
  }

  Widget _buildDaysOfWeek() {
    return Table(children: [
      TableRow(
          children: daysOfWeek2
              .map((e) => TableCell(
                  child: Center(
                      child: Text(e.toString(),
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)))))
              .toList())
    ]);
  }

  @override
  Widget build(BuildContext context) {
    const int initialPage = 48;
    DateTime now = new DateTime.now();
    DateTime baseDateTime = new DateTime(now.year, now.month, 1);
    _pageController = PageController(initialPage: initialPage);
    _monhtsLabel = new StreamController<String>();
    _updateMonthStream(baseDateTime);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: isPortrait ? 1.0 : 0.5,
        heightFactor: 1.0,
        child: Column(
          children: <Widget>[
            Container(
              alignment: isPortrait ? Alignment.center : Alignment.centerLeft,
              child: StreamBuilder(
                stream: _monhtsLabel.stream,
                builder: (BuildContext context, snapshot) {
                  return Text(
                    snapshot.data.toString(),
                    style: Theme.of(context).textTheme.display1,
                  );
                },
              ),
            ),
            Container(
                child: _buildDaysOfWeek(), margin: EdgeInsets.only(top: 15)),
            Divider(),
            Container(
                margin: EdgeInsets.only(top: 5),
//            color: Colors.red,
                child: SizedBox(
                  width: double.infinity,
                 height: 200,
                  child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (valueChanged) {
                        _updateMonthStream(_getSelectedDate(
                            valueChanged, initialPage, baseDateTime));
                      },
                      itemBuilder: (BuildContext context, int idx) {
                        return Container(
                            child: Calendar(
                                goNextPage: this._goNextCalendarPage,
                                goPreviousPage: this._goPreviousCalendarPage,
                                baseDateDay: _getSelectedDate(
                                    idx, initialPage, baseDateTime)));
                      }),
                ))
          ],
        ),
      ),
    );
  }


  void _goNextCalendarPage() {
     if (_pageController != null) {
       _pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.fastLinearToSlowEaseIn);
     }
  }

  void _goPreviousCalendarPage() {
    if (_pageController != null) {
      _pageController.previousPage(duration: Duration(milliseconds: 1000), curve: Curves.fastLinearToSlowEaseIn);
    }
  }
}
