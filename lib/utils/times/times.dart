import 'package:intl/intl.dart';

class CurrentTimes {
  static final currentTime = DateTime.now();
  static final DateFormat formattedTime = DateFormat('HH:mm');
  static final String time = formattedTime.format(currentTime);
  static final DateFormat formattedDate = DateFormat('dd MMMM');
  static final String date = formattedDate.format(currentTime);
}
