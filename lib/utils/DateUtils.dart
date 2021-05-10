import 'package:intl/intl.dart';

class DateUtils {

  static String getMessageTime(String messageTimeStamp) {
    var dTimeStamp = int.tryParse(messageTimeStamp);
    var date = DateTime.fromMillisecondsSinceEpoch(dTimeStamp);
    final DateFormat formatter = DateFormat('H:m, dd MMM');
    final String formatted = formatter.format(date);
    return formatted;
  }
}
