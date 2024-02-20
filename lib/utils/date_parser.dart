import 'package:intl/intl.dart';

class DateParser {
  static bool _isNumeric(String str) {
    // Regular expression to check if string is numeric
    return RegExp(r'^\d+$').hasMatch(str);
  }

  static DateTime? parseCustomFormat(String text) {
    if (text.length == 6) {
      String yearStr = '20${text.substring(0, 2)}';
      String monthStr = text.substring(2, 4);
      String dayStr = text.substring(4, 6);

      // Check if year, month, and day parts are numeric
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

      // Check if year, month, and day parts are numeric
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
    // Attempt to parse using custom formats first
    DateTime? customParsedDate = parseCustomFormat(text);
    if (customParsedDate != null) return customParsedDate;

    // List of DateFormat patterns to try if custom parsing fails
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
        // Ignore and try the next format
      }
    }

    // If none of the formats match, return null
    return null;
  }

  static bool isDate(String text) {
    // Attempt to parse the date using existing methods
    DateTime? parsedDate = parseDate(text);
    // Return true if a date is successfully parsed, false otherwise
    return parsedDate != null;
  }
}