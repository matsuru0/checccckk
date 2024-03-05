import 'package:flutter/material.dart';
import 'package:table_prototype/features/clientDetails_screen/client_details.dart';
import 'package:table_prototype/features/patients_screen/view/widgets/bar_text.dart';
import 'package:table_prototype/core/common/table_button.dart';

var decoration = InputDecoration(
  isDense: true,
  contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 7, right: 7),
  //  hintText: widget.hint,
  filled: true, // Set filled to true to enable background color
  fillColor: Colors.white,
  enabledBorder: OutlineInputBorder(
    // Specify the border type here
    borderRadius:
        BorderRadius.circular(5.0), // Adjust the border radius as needed
    borderSide: BorderSide(
      color: Color(0xffBABABA).withOpacity(1),
      width: 1, // Set the border color
    ),
  ),
);

class ClientDetailsBar extends StatefulWidget {
  const ClientDetailsBar(
      {super.key,
      required this.txt,
      required this.topText,
      required this.onchange});
  final String topText;
  final String txt;
  final Function(String) onchange;
  @override
  State<ClientDetailsBar> createState() => _ClientDetailsBarState();
}

class _ClientDetailsBarState extends State<ClientDetailsBar> {
  bool editable = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.topText,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        SizedBox(
          height: 7,
        ),
        bar_text(widget.txt, widget.onchange, decoration: decoration),
      ],
    );
  }
}
