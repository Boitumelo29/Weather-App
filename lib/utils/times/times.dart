import 'package:intl/intl.dart';

class CurrentTimes {
  static final currentTime = DateTime.now();
  static final DateFormat formattedTime = DateFormat('HH:mm');
  static final String time = formattedTime.format(currentTime);
  static final DateFormat formattedDate = DateFormat('dd MMMM');
  static final String date = formattedDate.format(currentTime);

 static String dailyMeeting() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;

    if (hour >= 0 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }
}
