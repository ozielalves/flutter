import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color buttonColor;
  final Function action;
  final bool outlined;
  final IconData icon;

  ActionButton({
    this.text,
    this.textColor,
    this.buttonColor,
    this.action,
    this.outlined = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: action,
      elevation: outlined ? 0 : 2.0,
      fillColor: outlined ? Colors.transparent : buttonColor,
      child: icon != null
          ? Icon(
              icon,
              size: 30.0,
              color: Colors.white,
            )
          : Text(text,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  color: textColor)),
      padding: icon != null
          ? EdgeInsets.all(7.0)
          : EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      shape: icon != null
          ? CircleBorder()
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              side: BorderSide(
                  width: 2,
                  color: outlined ? buttonColor : Colors.transparent)),
      constraints: BoxConstraints(minWidth: 0),
    );
  }
}