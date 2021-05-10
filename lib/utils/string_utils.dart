class CustomStringUtils {

  /// retrieve the display name from the string
  static String getChatDisplayName(String input) {
    try {
      int space1 = input.indexOf(' ');
      return input.substring(0, space1);
    } catch(e) {
      print(e);
      return '';
    }
  }
}