import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_firebase/custom_widgets/back_button_widget.dart';
import 'package:flash_chat_firebase/custom_widgets/rounded_button.dart';
import 'package:flash_chat_firebase/utils/app_constants.dart';
import 'package:flash_chat_firebase/utils/custom_styles.dart';
import 'package:flash_chat_firebase/view/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mAuth = FirebaseAuth.instance;
  String _mEmail;
  String _mPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: EdgeInsets.all(5.0),
        child: ModalProgressHUD(
          inAsyncCall: kShowProgress,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                BackButtonWidget(),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                          height: 200.0,
                          child: Image.asset('images/chat.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        _mEmail = value;
                      },
                      obscureText: false,
                      decoration: kInputDecorationStyle.copyWith(
                          hintText: 'Enter your email'),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        _mPassword = value;
                      },
                      obscureText: true,
                      decoration: kInputDecorationStyle.copyWith(
                          hintText: 'Enter your password'),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),

                    ///Login Button
                    RoundedButtons(
                      mColor: Colors.lightBlueAccent,
                      mButtonLabel: 'Log In',
                      onPressed: () async {
                        setState(() {
                          FocusScope.of(context).unfocus();
                          kShowProgress = true;
                        });

                        try {
                          final loggedInUser = await _mAuth.currentUser;

                          if (loggedInUser == null) {
                            final user = _mAuth.signInWithEmailAndPassword(
                                email: _mEmail, password: _mPassword);

                            if (user != null) {
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                          } else {
                            // user is already logged in. Navigate user to chat screen
                            Navigator.pushReplacementNamed(context, ChatScreen.id);
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        } catch (e) {
                          print(e);
                        }

                        setState(() {
                          kShowProgress = true;
                        });

                        Navigator.pushReplacementNamed(context, ChatScreen.id);
                      },
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
