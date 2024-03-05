import 'package:flutter/material.dart';


class CustomColors {
  static const red = Color(0xffD2042D);
   static const green = Color(0xff228b22);

}

void showSnackBar(BuildContext context, String text, Color color) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color ?? Colors.black26,
      ),
    );
}
