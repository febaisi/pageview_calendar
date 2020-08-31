

class CalendarUtil {

  List<DateTime> buildDisplayedDates(DateTime firstDayOfMonth) {
    if (firstDayOfMonth.day != 1) {
      return null;
    }
    List<DateTime> calendarDaysList = new List<DateTime>();
builderror
    //Add days from previous months if needed
    int baseDayCount =
        firstDayOfMonth.weekday; // First day displayed is Sunday (7)
    if (baseDayCount < 7) {
      List.generate(
          baseDayCount,
              (index) => {
            calendarDaysList.add(firstDayOfMonth
                .subtract(new Duration(days: baseDayCount - index)))
          });
    }

    //We always 42 days displayed - no matter what
    List.generate(
        (42 - calendarDaysList.length),
            (index) => {
          calendarDaysList.add((new DateTime(firstDayOfMonth.year, firstDayOfMonth.month, firstDayOfMonth.day + index)))
        });

    return calendarDaysList;
  }

}
