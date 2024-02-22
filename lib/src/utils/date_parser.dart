import 'package:intl/intl.dart';

class DateParser {
  static bool _isNumeric(String str) {
    return RegExp(r'^\d+$').hasMatch(str);
  }

  static DateTime? parseCustomFormat(String text) {
    if (text.length == 6) {
      String yearStr = '20${text.substring(0, 2)}';
      String monthStr = text.substring(2, 4);
      String dayStr = text.substring(4, 6);

      if (_isNumeric(yearStr) && _isNumeric(monthStr) && _isNumeric(dayStr)) {
        int year = int.parse(yearStr);
        int month = int.parse(monthStr);
        int day = int.parse(dayStr);

        if (!isValid(year, month, day)) {
          return null;
        }

        return DateTime(year, month, day);
      }
    } else if (text.length == 8) {
      String yearStr = text.substring(0, 4);
      String monthStr = text.substring(4, 6);
      String dayStr = text.substring(6, 8);

      if (_isNumeric(yearStr) && _isNumeric(monthStr) && _isNumeric(dayStr)) {
        int year = int.parse(yearStr);
        int month = int.parse(monthStr);
        int day = int.parse(dayStr);

        if (!isValid(year, month, day)) {
          return null;
        }
        return DateTime(year, month, day);
      }
    }
    return null;
  }



  static bool isValid(int year, int month, int day) {
    if (month > 12) {
      return false;
    }
    if (year < 1900 || year > 2100) {
      return false;
    }
    if (day > 31 || day < 1) {
      return false;
    }
    return true;
  }

  static DateTime? parseDate(String text) {
    DateTime? customParsedDate = parseCustomFormat(text);
    if (customParsedDate != null) return customParsedDate;

    List<String> formats = [
      'yyyy.MM.dd',
      'yyyy-MM-dd',
      'yyyy년MM월dd일',
      'yyyy/MM/dd',
    ];

    for (String format in formats) {
      try {
        final DateFormat formatter = DateFormat(format);
        return formatter.parseStrict(text);
      } catch (e) {
        continue;
      }
    }

    return null;
  }

  static bool isDate(String text) {
    DateTime? parsedDate = parseDate(text);
    return parsedDate != null;
  }

  static DateTime? parseDateIfBeforeToday(String text) {
    DateTime? parsedDate = parseDate(text);
    if (parsedDate != null) {
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      if (parsedDate.isBefore(today) || isSameDay(parsedDate, today)) {
        return parsedDate;
      }
    }
    return null;
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
}