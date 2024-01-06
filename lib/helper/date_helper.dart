enum Date { YESTERDAY, TODAY, OTHERDAY }

class DateHelper {
  static Date getDate(DateTime date) {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    DateTime today = DateTime(now.year, now.month, now.day);
    if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return Date.YESTERDAY;
    } else if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return Date.TODAY;
    } else {
      return Date.OTHERDAY;
    }
  }
}