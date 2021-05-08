
import 'package:flash_chat_firebase/utils/custom_styles.dart';
import 'package:flutter/material.dart';

class LoginScreenButtons extends StatelessWidget {

  LoginScreenButtons({this.mColor, this.mButtonLabel, this.onPressed});

  final MaterialAccentColor mColor;
  final String mButtonLabel;
  final Function onPressed;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: mColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            mButtonLabel,
            style: kLoginScreenButtonStyle,
          ),
        ),
      ),
    );
  }
}