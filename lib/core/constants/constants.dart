import 'package:flutter/material.dart';
import 'package:table_prototype/theme/pallete.dart';

class Constants {
  static const logoPath = 'assets/logo.png';
  static Border border = Border.all(
    color: Pallete.borderStrokeColor,
    style: BorderStyle.solid,
    width: 1,
  );

  static var decoration = InputDecoration(
    isDense: true,

    border: InputBorder.none,
    contentPadding: EdgeInsets.only(top: 14, bottom: 14, left: 7, right: 7),
    //  hintText: widget.hint,
    /* filled: true, // Set filled to true to enable background color
    fillColor: Pallete.inputFillColor,
    enabledBorder: OutlineInputBorder(
      // Specify the border type here
      borderRadius:
          BorderRadius.circular(7.0), // Adjust the border radius as needed
      borderSide: const BorderSide(
        color: Pallete.borderStrokeColor,
        style: BorderStyle.solid,
        width: 1, // Set the border color
      ),
    ),*/
  );
}
