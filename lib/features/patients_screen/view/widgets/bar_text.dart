import 'package:flutter/material.dart';
import 'package:table_prototype/core/constants/constants.dart';
import 'package:table_prototype/theme/pallete.dart';

const defaultDecoration = const InputDecoration(
  border: InputBorder.none,
);

SizedBox bar_text(String txt, Function(String) onChange,
        {InputDecoration decoration = defaultDecoration,
        double customWidth = 150,
        icon = null,
        int maxlines = 1,
        bool instantChange = false,
        bool isDisabled = false}) =>
    SizedBox(
        width: customWidth,
        child: bar_text_field(
            txt, onChange, decoration, customWidth, icon, maxlines, isDisabled,
            instantChange: instantChange));

class bar_text_field extends StatefulWidget {
  bar_text_field(this.txt, this.onChange, this.decoration, this.customWidth,
      this.icon, this.maxlines, this.isDisabled,
      {this.instantChange = false});
  final String txt;
  final bool isDisabled;
  final bool instantChange;
  final Function(String) onChange;
  final InputDecoration decoration;
  final double customWidth;
  final icon;
  final int maxlines;
  @override
  State<bar_text_field> createState() => _bar_text_fieldState();
}

class _bar_text_fieldState extends State<bar_text_field> {
  FocusNode firstFocusNode = FocusNode();
  var controller1 = TextEditingController();
  @override
  void initState() {
    print(widget.maxlines);
    controller1.text = widget.txt;
    super.initState();
    firstFocusNode.addListener(() {
      if (!firstFocusNode.hasFocus && controller1.text != widget.txt) {
        method();
      }
    });
  }

  void method() {
    widget.onChange(controller1.text);
  }

  @override
  void dispose() {
    super.dispose();
    firstFocusNode.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    controller1.text = widget.txt;
    return Container(
      child: TextFormField(
        readOnly: widget.isDisabled ? true : false,
        decoration: widget.decoration,
        focusNode: firstFocusNode,
        onChanged: (val) {
          if (widget.instantChange) {
            method();
          }
        },
        controller: controller1,
        maxLines: widget.maxlines,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.black,
        ),

        //controller: TextEditingController(text: widget.txt),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'enter a valid input';
          }
          return null;
        },
      ),
    );
    // widget.icon != null ? Icon(widget.icon) : SizedBox()
  }
}
//the text of the bar of table