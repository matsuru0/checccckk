import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:table_prototype/features/patients_screen/controller/clients_controller.dart';

import 'package:table_prototype/theme/pallete.dart';

class FilterBy extends StatefulWidget {
  const FilterBy(
    this.notifier, {
    super.key,
  });
  final ClientNotifier notifier;
  @override
  State<FilterBy> createState() => _FilterByState();
}

class _FilterByState extends State<FilterBy> {
  List<String> filtred = [];
  final List<String> items = [
    'name',
    'familyName',
    'ville',
    'phone',
    'Last visit'
  ];
  String? selectedValue = 'familyName';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(10), // Adjust the radius as needed
          color: Pallete.lightBlueColor),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: const Text(
            'Search by',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          items: items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (String? value) {
            setState(() {
              selectedValue = value;
              widget.notifier.setLookUpSetting(selectedValue ?? '');
            });
          },
          iconStyleData: IconStyleData(
              icon: Icon(Icons.arrow_drop_down, color: Colors.white)),
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            width: 130,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
          selectedItemBuilder: (BuildContext context) {
            return items.map(
              (String item) {
                return Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    selectedValue ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color:
                          Colors.white, // Set the selected text color to white
                    ),
                  ),
                );
              },
            ).toList();
          },
        ),
      ),
    );
  }
}
