import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_firebase/custom_widgets/back_button_widget.dart';
import 'package:flash_chat_firebase/custom_widgets/rounded_button.dart';
import 'package:flash_chat_firebase/utils/app_constants.dart';
import 'package:flash_chat_firebase/utils/custom_styles.dart';
import 'package:flash_chat_firebase/utils/string_constants.dart'
    as StringConstant;
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _mAuth = FirebaseAuth.instance;
  String _mEmail;
  String _mPassword;
  String _mFirstName;
  String _mLastName;
  String _mMobileNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: kShowProgress,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ///back button widget
                BackButtonWidget(),

                ///login ui
                Expanded(
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(5.0),
                      children: <Widget>[
                        Hero(
                          tag: 'logo',
                          child: Container(
                            height: 200.0,
                            child: Image.asset('images/chat.png'),
                          ),
                        ),
                        SizedBox(
                          height: 48.0,
                        ),

                        ///first name
                        TextField(
                          style: kRegularInputTextStyle,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) {
                            _mFirstName = value;
                          },
                          obscureText: false,
                          decoration: kInputDecorationStyle.copyWith(
                              hintText: kHintEnterYourFirstName),
                        ),

                        SizedBox(
                          height: 8.0,
                        ),

                        /// Last Name
                        TextField(
                          style: kRegularInputTextStyle,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) {
                            _mLastName = value;
                          },
                          obscureText: false,
                          decoration: kInputDecorationStyle.copyWith(
                              hintText: kHintEnterYourLastName),
                        ),

                        SizedBox(
                          height: 8.0,
                        ),

                        /// Mobile number
                        TextField(
                          style: kRegularInputTextStyle,
                          textAlign: TextAlign.center,
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            _mMobileNumber = value;
                          },
                          obscureText: false,
                          decoration: kInputDecorationStyle.copyWith(
                              hintText: kHintEnterYourMobile),
                        ),

                        SizedBox(
                          height: 8.0,
                        ),

                        /// Email address
                        TextField(
                          style: kRegularInputTextStyle,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            _mEmail = value;
                          },
                          obscureText: false,
                          decoration: kInputDecorationStyle.copyWith(
                              hintText: kHintEnterYourEmailAddress),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),

                        /// Password
                        TextField(
                          style: kRegularInputTextStyle,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            _mPassword = value;
                          },
                          obscureText: true,
                          decoration: kInputDecorationStyle.copyWith(
                              hintText: kHintEnterYourPassword),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),

                        /// register button
                        RoundedButtons(
                          mColor: Colors.blueAccent,
                          mButtonLabel: StringConstant.kLblRegister,
                          onPressed: () async {
                            setState(() {
                              kShowProgress = true;
                              FocusScope.of(context).unfocus();
                            });
                            try {
                              final newUser =
                                  await _mAuth.createUserWithEmailAndPassword(
                                      email: _mEmail, password: _mPassword);
                              print(newUser);
                              if (newUser != null) {
                                User user = newUser.user;
                                user.updateProfile(
                                    displayName:
                                        '$_mFirstName $_mLastName / $_mMobileNumber');
                                Navigator.pushReplacementNamed(
                                    context, ChatScreen.id);
                              } else {
                                print('Something wrong while create user');
                              }
                            } catch (e) {
                              print('Something wrong while create user $e');
                            }
                            setState(() {
                              kShowProgress = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
