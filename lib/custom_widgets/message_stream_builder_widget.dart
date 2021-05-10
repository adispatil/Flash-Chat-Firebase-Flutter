import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_firebase/custom_widgets/message_bubble_widget.dart';
import 'package:flash_chat_firebase/utils/app_constants.dart';
import 'package:flash_chat_firebase/utils/string_utils.dart';
import 'package:flutter/material.dart';

class MessageStreamBuilder extends StatelessWidget {

  MessageStreamBuilder({this.mFirestore, this.myEmail});

  final FirebaseFirestore mFirestore;
  final String myEmail;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: mFirestore.collection(kFirebaseCollectionName).snapshots(),
      builder: (context, snapshots) {
        if (!snapshots.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }
        final messages = snapshots.data.docs.reversed;
        List<MessageBubble> messageBubblesWidgets = [];

        messages.forEach((element) {
          final messageText = element[kFirebaseKeyText];
          final messageSender = element[kFirebaseKeyDisplayName];
          final timestamp = element[kFirebaseKeyTimestamp];
          final senderEmail = element[kFirebaseKeySender];

          final messageBubbleWidget = MessageBubble(
            messageText: messageText,
            messageSender: CustomStringUtils.getChatDisplayName(messageSender),
            messageTimeStamp: timestamp,
            isMe: myEmail == senderEmail ? true : false,
          );
          messageBubblesWidgets.add(messageBubbleWidget);
        });

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            children: messageBubblesWidgets,
          ),
        );
      },
    );
  }
}
