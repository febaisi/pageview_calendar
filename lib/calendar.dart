import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:pageview_calendar/business/calendar_util.dart';

class Calendar extends StatefulWidget {
  DateTime baseDateDay;
  Function goNextPage;
  Function goPreviousPage;

  Calendar(
      {@required this.baseDateDay,
      @required this.goNextPage,
      @required this.goPreviousPage})
      : assert(baseDateDay != null),
        assert(goPreviousPage != null),
        assert(goNextPage != null);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final calendarUtil = CalendarUtil();
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    var now = new DateTime.now();
    _selectedDate =
        (_isSameMonth(now, widget.baseDateDay)) ? now : widget.baseDateDay;
  }

  Widget _buildCalendarDaysWidget(DateTime firstDayOfMonth) {
    return Table(children: _buildCalendarDays(firstDayOfMonth));
  }

  List<TableRow> _buildCalendarDays(DateTime firstDayOfMonth) {
    var now = new DateTime.now();
    List<DateTime> displayedDates = calendarUtil.buildDisplayedDates(firstDayOfMonth);

    //We always have 6 rows
    return new List.generate(
        6,
        (index) => TableRow(
            children: new List.generate(
                7,
                (index) => TableCell(
                        child: Container(
                      child: _buildDateWithCircle(
                          now, firstDayOfMonth, displayedDates.removeAt(0)),
                    ))).toList()));
  }

  bool shouldGoRight(DateTime date1, DateTime date2) {
    if (date2.year > date1.year) {
      return true;
    } else if (date2.year < date1.year) {
      return false;
    } else if (date2.month > date1.month) {
      return true;
    } else {
      return false;
    }
  }

  Widget _buildDateWithCircle(
      DateTime now, DateTime firstDayOfMonth, DateTime displayedDate) {
    return GestureDetector(
      onTap: () {
        if (_isSameMonth(widget.baseDateDay, displayedDate)) {
          setState(() {
            _selectedDate = displayedDate;
          });
        } else {
          if (shouldGoRight(widget.baseDateDay, displayedDate)) {
            widget.goNextPage();
          } else {
            widget.goPreviousPage();
          }
        }
      },
      child: Container(
        height: 45,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.transparent),
        ),
        child: Container(
          // double container to make the clickable area bigger
          decoration: isSameDay(_selectedDate, displayedDate)
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                )
              : null,
          child: Center(
              child: Text(displayedDate.day.toString(),
                  style: _defineDayTextStyle(
                      now, firstDayOfMonth, displayedDate))),
        ),
      ),
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    if (date1 != null &&
        date2 != null &&
        (date1.month == date2.month &&
            date1.day == date2.day &&
            date1.year == date2.year)) {
      return true;
    } else {
      return false;
    }
  }

  TextStyle _defineDayTextStyle(
      DateTime today, DateTime firstDayOfMonth, DateTime toCompare) {
    const defaultFontSize = 17.0;
    if (_isDateToday(today, toCompare)) {
      return TextStyle(
          fontSize: defaultFontSize,
          fontWeight: FontWeight.bold,
          color: Colors.blue);
    } else if (_isSameMonth(firstDayOfMonth, toCompare)) {
      return TextStyle(fontSize: defaultFontSize);
    } else {
      return TextStyle(
          fontSize: defaultFontSize, color: Colors.grey.withOpacity(0.4));
    }
  }

  bool _isSameMonth(DateTime today, DateTime toCompare) {
    return (today.month == toCompare.month) ? true : false;
  }

  bool _isSelectedDate(DateTime toCompare) {
    return (this._selectedDate == null ||
            toCompare == null ||
            (this._selectedDate.day != toCompare.day ||
                this._selectedDate.month != toCompare.month ||
                this._selectedDate.year != toCompare.year)
        ? false
        : true);
  }

  bool _isDateToday(DateTime today, DateTime toCompare) {
    return (today.day == toCompare.day &&
            today.month == toCompare.month &&
            today.year == toCompare.year)
        ? true
        : false;
  }


  @override
  Widget build(BuildContext context) {
    return Container(child: _buildCalendarDaysWidget(widget.baseDateDay));
  }
}
