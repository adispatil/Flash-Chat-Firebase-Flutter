import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_firebase/custom_widgets/message_stream_builder_widget.dart';
import 'package:flash_chat_firebase/utils/app_constants.dart';
import 'package:flash_chat_firebase/utils/custom_styles.dart';
import 'package:flash_chat_firebase/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _mAuth = FirebaseAuth.instance;
  final _mFirestore = FirebaseFirestore.instance;
  User _mLoggedInUser;
  String _mMessageText;
  var _mController = TextEditingController();
  String loggedInUserEmail = ' ';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _mAuth.currentUser;
      if (user != null) {
        _mLoggedInUser = user;
        setState(() {
          loggedInUserEmail = user.email;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.white,
              ),
              onPressed: () {
                _mAuth.signOut();
                Navigator.pushReplacementNamed(context, LoginScreen.id);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            /// Stream builder
            MessageStreamBuilder(mFirestore: _mFirestore, myEmail: loggedInUserEmail,),

            /// Message typing widget
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _mController,
                      onChanged: (value) {
                        _mMessageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.only(right: 5.0),
                    icon: Icon(
                      FontAwesomeIcons.chevronCircleRight,
                      color: Colors.blue,
                      size: 30.0,
                    ),
                    onPressed: () {
                      _mFirestore.collection(kFirebaseCollectionName).add({
                        kFirebaseKeySender: _mLoggedInUser.email,
                        kFirebaseKeyText: _mMessageText,
                        kFirebaseKeyTimestamp:
                            DateTime.now().millisecondsSinceEpoch.toString(),
                        kFirebaseKeyDisplayName: _mLoggedInUser.displayName
                      });
                      _mController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

