import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:table_prototype/core/constants/constants.dart';
import 'package:table_prototype/models/treatement_model.dart';
import 'package:table_prototype/theme/pallete.dart';

class TemplatesDropDown extends StatefulWidget {
  const TemplatesDropDown(
      this.customWidth, this.templates, this.setCurrentTemplate,
      {super.key});
  final double customWidth;
  final List<String> templates;
  final Function(int) setCurrentTemplate;
  @override
  State<TemplatesDropDown> createState() => _TemplatesDropDownState();
}

class _TemplatesDropDownState extends State<TemplatesDropDown> {
  List<String> items = [];

  String? selectedValue;

  @override
  void initState() {
    super.initState();
    items = widget.templates;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Templates  ',
            style: const TextStyle(
                color: Color(0xff433B35),
                fontSize: 13,
                fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 40,
          width: widget.customWidth - 48,
          decoration: BoxDecoration(
              border: Constants.border,
              borderRadius:
                  BorderRadius.circular(7), // Adjust the radius as needed
              color: Pallete.inputFillColor),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text('Select Item',
                  style: const TextStyle(
                      color: Color(0xff433B35),
                      fontSize: 13,
                      fontWeight: FontWeight.w500)),
              items: items
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,
                            style: const TextStyle(
                                color: Color(0xff433B35),
                                fontSize: 13,
                                fontWeight: FontWeight.w500)),
                      ))
                  .toList(),
              value: selectedValue,
              onChanged: (String? value) {
                setState(() {
                  var index = items.indexOf(value!);
                  widget.setCurrentTemplate(index);
                  selectedValue = value;
                });
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
      ],
    );
  }
}
