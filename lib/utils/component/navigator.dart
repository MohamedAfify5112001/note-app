import 'package:flutter/material.dart';

void navigateToPush(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
}

void navigateToPushReplacement(BuildContext context, Widget screen) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => screen));
}

void popToPreviousScreen(BuildContext context) {
  Navigator.of(context).pop();
}
