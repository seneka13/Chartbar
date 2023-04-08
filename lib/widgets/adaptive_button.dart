import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextButton extends StatelessWidget {
  final String text;
  final Function onPress;

  AdaptiveTextButton({this.text, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPress,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : TextButton(
            onPressed: onPress,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor),
          );
  }
}
