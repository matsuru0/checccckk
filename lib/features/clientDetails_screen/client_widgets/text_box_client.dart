import 'package:flutter/material.dart';
import 'package:table_prototype/core/constants/constants.dart';
import 'package:table_prototype/features/patients_screen/view/widgets/bar_text.dart';
import 'package:table_prototype/theme/pallete.dart';

class TextBoxClient extends StatelessWidget {
  final String topTxt;
  final String txt;
  final Function(String) onChange;
  final double customWidth;
  final InputDecoration? decoration1; // Make it nullable
  final icon;
  final VoidCallback? onTap;
  final int maxLines;
  final bool instantChange;
  final bool isDisabled;
  const TextBoxClient(
    this.topTxt,
    this.txt,
    this.onChange, {
    required this.customWidth,
    this.decoration1, // Make it nullable
    this.icon,
    this.onTap,
    this.maxLines = 1,
    this.instantChange = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    var decoration = decoration1 ?? Constants.decoration;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(topTxt,
            style: const TextStyle(
                color: Color(0xff433B35),
                fontSize: 13,
                fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: maxLines == 1 ? 40 : 120,
          padding: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: Pallete.inputFillColor,
              border: Constants.border,
              borderRadius: BorderRadius.circular(7)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bar_text(txt, onChange,
                  decoration: decoration ?? Constants.decoration,
                  customWidth: customWidth - 60,
                  icon: icon,
                  maxlines: maxLines,
                  instantChange: instantChange,isDisabled:isDisabled),
              icon != null
                  ? MouseRegion(
                      cursor: onTap != null
                          ? SystemMouseCursors.click
                          : SystemMouseCursors.alias,
                      child: GestureDetector(
                          onTap: onTap ?? () {}, child: Icon(icon)))
                  : SizedBox()
              //Icon(Icons.cabin)
            ],
          ),
        ),
      ],
    );
  }
}
