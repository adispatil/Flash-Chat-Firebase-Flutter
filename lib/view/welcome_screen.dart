import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat_firebase/custom_widgets/rounded_button.dart';
import 'package:flash_chat_firebase/view/login_screen.dart';
import 'package:flash_chat_firebase/view/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _mController;
  Animation _mAnimation;

  @override
  void initState() {
    super.initState();

    _mController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _mAnimation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(_mController);
    _mController.forward();
    _mController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _mAnimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ///title & image
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/chat.png'),
                    height: 80.0,
                    width: 80.0,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                SizedBox(
                  width: 250.0,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black38),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('Flash Chat'),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 48.0,
            ),

            ///button sign in
            RoundedButtons(
                mColor: Colors.lightBlueAccent,
                mButtonLabel: 'Sign In',
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),

            ///button sign up
            RoundedButtons(
                mColor: Colors.blueAccent,
                mButtonLabel: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
