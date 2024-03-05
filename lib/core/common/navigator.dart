import 'package:flutter/material.dart';

import 'package:table_prototype/theme/pallete.dart';

class LeftBarNavigator extends StatelessWidget {
  const LeftBarNavigator(this.txt, this.imgFinal, this.setSelectedIndex,
      {this.active = false, this.pageIndex = 0, super.key});
  final String txt;
  final String imgFinal;
  final bool active;
  final Function(int) setSelectedIndex;
  final int pageIndex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            setSelectedIndex(pageIndex);
          },
          child: Container(
            padding: const EdgeInsets.only(top: 1, bottom: 1),
            decoration: BoxDecoration(
              color: active ? Pallete.darkedBlueColor : Colors.transparent,
              borderRadius:
                  BorderRadius.circular(10.0), // Set the desired corner radius
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/' + imgFinal + '.png',
                    height: 25,
                    width: 25,
                    filterQuality: FilterQuality.medium,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10),
                  Text(txt,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter0',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
