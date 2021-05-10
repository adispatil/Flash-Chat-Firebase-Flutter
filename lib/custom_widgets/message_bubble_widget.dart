import 'package:flash_chat_firebase/utils/DateUtils.dart' as DateParser;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {this.messageText, this.messageSender, this.messageTimeStamp, this.isMe});

  final String messageText;
  final String messageSender;
  final String messageTimeStamp;
  final bool isMe;

  BorderRadius getBorderRadius() {
    if(isMe) {
      return BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
      );
    } else {
      return BorderRadius.only(
        topRight: Radius.circular(30.0),
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            messageSender,
            style: GoogleFonts.itim(
              textStyle: TextStyle(
                fontSize: 12.0,
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Material(
            borderRadius: getBorderRadius(),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$messageText',
                style: GoogleFonts.itim(
                  textStyle: TextStyle(
                    fontSize: 17.0,
                    color: isMe ? Colors.white70 : Colors.lightBlueAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
          Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Text(
                DateParser.DateUtils.getMessageTime(messageTimeStamp),
                style: TextStyle(
                  fontSize: 8.0,
                  fontStyle: FontStyle.italic,
                ),
              )),
        ],
      ),
    );
  }
}
