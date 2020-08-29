import 'package:flutter_test/flutter_test.dart';
import 'package:pageview_calendar/business/calendar_util.dart';
import 'dart:developer' as developer;

void main() {
  var calendarUtil = CalendarUtil();

  test("buildDisplayedDates build based on 1st day of the month", () {
    var now = new DateTime.now();
    if (now.day == 1) {
      now.add(Duration(days: 1));
    }
    var displayDates = calendarUtil.buildDisplayedDates(now);
    expect(null, displayDates);
  });

  test("testing display days amount", () {
    DateTime now = new DateTime.now();
    //Check for at least 72 months to eventually hit a leap year
    for (var i = 0; i < 77; i++) {
      DateTime firstMonthDay = new DateTime(now.year, now.month + i, 1);
      var displayDates = calendarUtil.buildDisplayedDates(firstMonthDay);
      //print("Testing ${firstMonthDay.year}/${firstMonthDay.month}/${firstMonthDay.day}");
      expect(42, displayDates.length);
    }
  });

  /*
  static const int monday = 1;
  static const int tuesday = 2;
  static const int wednesday = 3;
  static const int thursday = 4;
  static const int friday = 5;
  static const int saturday = 6;
  static const int sunday = 7;
  */
  test("testing first day of month position", () {
    DateTime now = new DateTime.now();
    //Check for at least 72 months to eventually hit a leap year
    for (var i = 0; i < 77; i++) {
      DateTime firstMonthDay = new DateTime(now.year, now.month + i, 1);
      var weekday = firstMonthDay.weekday;
      var displayDates = calendarUtil.buildDisplayedDates(firstMonthDay);
      expect(1, displayDates[weekday != 7 ? weekday : 0].day);
    }
  });

  test("check if calendar is not repeating days", () {
    DateTime now = new DateTime.now();
    //Check for at least 72 months to eventually hit a leap year
    for (var i = 0; i < 77; i++) {
      DateTime firstMonthDay = new DateTime(now.year, now.month + i, 1);
      var displayDates = calendarUtil.buildDisplayedDates(firstMonthDay);
      for (var i = 0; i < displayDates.length - 1; i++) {
        var firstDay = displayDates[i];
        var nextDay = displayDates[i + 1];
        //print("$firstDay and $nextDay");
        expect(
            true, (firstDay.isBefore(nextDay) && firstDay.day != nextDay.day));
      }
    }
  });

  test("check last calendar day", () {
    DateTime now = new DateTime.now();
    //Check for at least 72 months to eventually hit a leap year
    for (var i = 0; i < 77; i++) {
      DateTime firstMonthDay = new DateTime(now.year, now.month + i, 1);
      var displayDates = calendarUtil.buildDisplayedDates(firstMonthDay);
      var weekday = firstMonthDay.weekday;
      var initialGap = (weekday == 7) ? 0 : weekday;
      var remainingDays = 42 -
          (initialGap +
              DateTime(firstMonthDay.year, firstMonthDay.month + 1, 0).day);
      expect(displayDates[displayDates.length - 1].day, remainingDays);
    }
  });

  test("check first day of the list", () {
    DateTime now = new DateTime.now();
    //Check for at least 72 months to eventually hit a leap year
    for (var i = 0; i < 77; i++) {
      DateTime firstMonthDay = new DateTime(now.year, now.month + i, 1);
      var displayDates = calendarUtil.buildDisplayedDates(firstMonthDay);
      var weekday = firstMonthDay.weekday;
      var initialGap = (weekday == 7) ? 0 : weekday;
      expect(
          displayDates[0],
          initialGap == 0
              ? firstMonthDay
              : new DateTime(firstMonthDay.year, firstMonthDay.month,
                  firstMonthDay.day - initialGap));
    }
  });

  //dart issue
  // test("check november 2020 Date obj issue", () {
  //     DateTime novOne = new DateTime(2020, 11, 1);
  //     expect(2, novOne.day);
  // });
}
