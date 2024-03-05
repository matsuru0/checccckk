import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:table_prototype/core/constants/constants.dart';
import 'package:table_prototype/features/patients_screen/controller/clients_controller.dart';
import 'package:table_prototype/models/antecedent_model.dart';
import 'package:table_prototype/models/client_model.dart';
import 'package:table_prototype/models/treatement_model.dart';
import 'package:table_prototype/theme/pallete.dart';

class AntecedentDropDown extends StatefulWidget {
  const AntecedentDropDown(
      this.customWidth, this.antecedents, this.clientNotifier, this.client,
      {super.key});
  final double customWidth;
  final ClientModel client;
  final List<AntecedentModel> antecedents;
  final ClientNotifier clientNotifier;
  @override
  State<AntecedentDropDown> createState() => _AntecedentDropDownState();
}

class _AntecedentDropDownState extends State<AntecedentDropDown> {
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    setItems();
  }

  String? selectedValue;
  void setItems() {
    items = [];
    widget.antecedents.forEach((element) {
      var index = widget.antecedents.indexOf(element);
      bool exists =
          widget.client.antecedents.any((ant) => ant.uid == element.uid);
      if (!exists) {
        items.add(element.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setItems();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*Text('antecedents    price:${price}',
            style: const TextStyle(
                color: Color(0xff433B35),
                fontSize: 13,
                fontWeight: FontWeight.w500)),*/
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 40,
          width: widget.customWidth - 48,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Add Item',
                style: TextStyle(
                    color: Color(0xff433B35),
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
              items: items.map((String item) {
                AntecedentModel specificAnt = widget.antecedents
                    .firstWhere((element) => element.uid == item);
                print("SPECIFI");
                print(specificAnt);
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    specificAnt.title,
                    style: TextStyle(
                      color: Color(0xff433B35),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              // value: selectedValue,
              onChanged: (String? value) {
                List<AntecedentModel> antecedents = widget.antecedents;
                AntecedentModel specificAnt =
                    antecedents.firstWhere((element) => element.uid == value);
                bool exists = widget.client.antecedents
                    .any((ant) => ant.uid == specificAnt.uid);
                if (!exists) {
                  var newAnt = AntecedentModel(
                      history: [],
                      uid: specificAnt.uid,
                      title: specificAnt.title,
                      value: '');

                  //   print(element);
                  exists =
                      widget.client.antecedents.any((ant) => ant.uid == value);

                  print(exists);

                  List<AntecedentModel> newList = [
                    ...widget.client.antecedents,
                    newAnt
                  ];
                  ClientModel newClient =
                      widget.client.copyWith(antecedents: newList);
                  widget.clientNotifier.editClient(
                      widget.client.uid, newClient.toJson(), context);

                  setState(() {
                    // selectedValue = value;
                  });
                }
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ),
        /*const SizedBox(
          height: 23,
        ),*/
      ],
    );
  }

  String extractNumber(String input) {
    // Regular expression to match numbers
    RegExp regExp = RegExp(r'\d+(\.\d+)?');

    // Find the first match in the input string
    RegExpMatch? match = regExp.firstMatch(input);

    // Extract the matched portion
    if (match != null) {
      return match.group(0) ?? ''; // Use the first capturing group
    } else {
      return '';
    }
  }
}
