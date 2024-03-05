import 'package:flutter/material.dart';
import 'package:table_prototype/features/patients_screen/controller/antecedent_controller.dart';
import 'package:table_prototype/features/patients_screen/view/widgets/bar_text.dart';
import 'package:table_prototype/core/common/table_button.dart';
import 'package:table_prototype/models/antecedent_model.dart';

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

class AntecedentList extends StatefulWidget {
  const AntecedentList(
      this.antecedents, this.setSelectedIndex, this.antecedentNotifier);
  final VoidCallback setSelectedIndex;
  final AntecedentNotifier antecedentNotifier;
  final List<AntecedentModel> antecedents;

  @override
  State<AntecedentList> createState() => _AntecedentListState();
}

class _AntecedentListState extends State<AntecedentList> {
  @override
  Widget build(BuildContext context) {
   
   
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              widget.setSelectedIndex();
            },
            child: Text('back')),
        ElevatedButton(
            onPressed: () {
              widget.antecedentNotifier.addAntecedent(context);
            },
            child: Text("create ant")),
        SizedBox(
            width: 400,
            height: 500,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.antecedents.length, //
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                    /*  bar_text(
                          decoration: decoration,
                          widget.antecedents[index].title,
                          true, (val) {
                   
                        var newAnt = widget.antecedents[index]
                            .copyWith(title: val)
                            .toJson();
                        widget.antecedentNotifier.editAntecedent(
                            widget.antecedents[index].uid, newAnt, context);
                      }),*/
                      TableButton(
                          onTap: () {
                            widget.antecedentNotifier.deleteAntecedent(
                                widget.antecedents[index].uid, context);
                          },
                          icon: Icons.delete)
                    ],
                  );
                })),
      ],
    );
  }
}
