import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:table_prototype/core/constants/constants.dart';
import 'package:table_prototype/models/treatement_model.dart';
import 'package:table_prototype/theme/pallete.dart';

class TreatementDropDown extends StatefulWidget {
  const TreatementDropDown(
      this.customWidth, this.treatements, this.setTreatement,
      {this.oldSelectedItems = const [], super.key});
  final double customWidth;
  final List<Treatement> oldSelectedItems;
  final List<Treatement> treatements;
  final Function(List<Treatement> t) setTreatement;
  @override
  State<TreatementDropDown> createState() => _TreatementDropDownState();
}

class _TreatementDropDownState extends State<TreatementDropDown> {
  List<String> items = [];
  List<Treatement> selectedItems = [];
  double price = 0;
  bool isDisabled = false;
  @override
  void initState() {
    super.initState();

    widget.treatements.forEach((element) {
      //  items.add('${element.name} ${element.price}Da');
      items.add(element.uid);
    });
  }

  var tempList;

  @override
  void didUpdateWidget(covariant TreatementDropDown oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.oldSelectedItems != null && widget.oldSelectedItems.length > 0) {
      price = 0;
      selectedItems = widget.oldSelectedItems;
      selectedItems.forEach((element) {
        price += element.price;
      });
      isDisabled = true;
      tempList = widget.oldSelectedItems.map((item) => item.name).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Treatements    price:${price}',
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
              hint: Text(
                !isDisabled ? 'Select Items' : tempList.join(', '),
                style: TextStyle(
                  fontSize: 12.0,
                  color: const Color.fromARGB(255, 31, 30, 30),
                ),
              ),
              items: isDisabled
                  ? []
                  : items.map((item) {
                      Treatement specificTrea = widget.treatements
                          .firstWhere((element) => element.uid == item);
                      if (!isDisabled) {}
                      return DropdownMenuItem(
                        value: item,
                        //disable default onTap to avoid closing menu when selecting an item
                        enabled: false,
                        child: StatefulBuilder(
                          builder: (context, menuSetState) {
                            Treatement specificTrea = widget.treatements
                                .firstWhere((element) => element.uid == item);
                            print("item $item");
                            print("specified ${specificTrea}");
                            final isSelected =
                                selectedItems.contains(specificTrea);
                            return InkWell(
                              onTap: () {
                                isSelected
                                    ? selectedItems.remove(specificTrea)
                                    : selectedItems.add(specificTrea);

                                //This rebuilds the StatefulWidget to update the button's text

                                var priceOfItem = extractNumber(
                                    specificTrea.price.toString());

                                if (isSelected) {
                                  price -= double.parse(priceOfItem);
                                } else {
                                  price += double.parse(priceOfItem);
                                }
                                widget.setTreatement(selectedItems);
                                //    print('yoo ${selectedItems.last.name}');
                                setState(() {});
                                //This rebuilds the dropdownMenu Widget to update the check mark
                                menuSetState(() {});
                              },
                              child: Container(
                                height: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [
                                    if (isSelected)
                                      const Icon(Icons.check_box_outlined)
                                    else
                                      const Icon(Icons.check_box_outline_blank),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        '${specificTrea.name} ${specificTrea.price.toString()}DA',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: const Color.fromARGB(
                                              255, 31, 30, 30),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
              //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
              value: items.isEmpty ? null : items.last,
              onChanged: (value) {},
              selectedItemBuilder: (context) {
                var newList = selectedItems.map((item) => item.name).toList();

                return items.map(
                  (item) {
                    return Container(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        newList.join(', '),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: const Color.fromARGB(255, 31, 30, 30),
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    );
                  },
                ).toList();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(left: 16, right: 8),
                height: 40,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.zero,
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
