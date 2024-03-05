import 'package:flutter/material.dart';
import 'package:table_prototype/core/constants/constants.dart';
import 'package:table_prototype/features/clientDetails_screen/client_details.dart';
import 'package:table_prototype/theme/pallete.dart';

class Sexe extends StatefulWidget {
  const Sexe(
    this.onChange,
    this.isAman, {
    super.key,
  });
  final bool isAman;
  final Function(bool) onChange;
  @override
  State<Sexe> createState() => _SexeState();
}

class _SexeState extends State<Sexe> {
  late bool isAmanBool;

  @override
  void initState() {
    super.initState();
    isAmanBool = widget.isAman;
  }

  void setIsAman(bool val) {
    setState(() {
      isAmanBool = val;
    });
    widget.onChange(val);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Sexe',
            style: TextStyle(
                color: Color(0xff433B35),
                fontSize: 13,
                fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 5,
        ),
        Container(
            width: 85,
            height: 40,
            padding: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
                color: Pallete.inputFillColor,
                border: Constants.border,
                borderRadius: BorderRadius.circular(7)),
            child: Row(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setIsAman(true);
                    },
                    child: Container(
                      child: Image.asset(
                        'assets/male_account_circle.png',
                        width: 30,
                        filterQuality: FilterQuality.medium,
                        color: !isAmanBool ? Color(0xffC2C2C2) : Colors.black,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setIsAman(false);
                    },
                    child: Container(
                      child: Image.asset(
                        'assets/female_account_circle.png',
                        color: isAmanBool ? Color(0xffC2C2C2) : Colors.black,
                        width: 30,
                        filterQuality: FilterQuality.medium,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
