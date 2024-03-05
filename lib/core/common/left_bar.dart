import 'package:flutter/material.dart';
import 'package:table_prototype/core/common/navigator.dart';
import 'package:table_prototype/core/constants/constants.dart';
import 'package:table_prototype/theme/pallete.dart';

class LeftBarConstants {
  static const double leftBarWidth = 280;
}

class LeftBar extends StatelessWidget {
  const LeftBar(this.setSelectedIndex, this.selectedIndex, {super.key});
  final int selectedIndex;
  final Function(int) setSelectedIndex;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;

    double screenWidth = mediaQueryData.size.width;
    // print(screenWidth * 0.2);
    return Container(
        constraints: BoxConstraints(minWidth: 240, maxWidth: 300),
        width: screenWidth * 0.2,
        padding: const EdgeInsets.only(top: 20, left: 11, right: 25),
        color: Pallete.blueColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  Constants.logoPath,
                  height: 82,
                  width: 82,
                  filterQuality: FilterQuality.medium,
                ),
                const Text("Med plus",
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'Inter0',
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600))
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Menu",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter0',
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LeftBarNavigator('Pateints', 'group', setSelectedIndex,
                      active: selectedIndex == 0, pageIndex: 0),
                  LeftBarNavigator('Rendez-vous', 'clock', setSelectedIndex,
                      pageIndex: 1, active: selectedIndex == 1),
                  LeftBarNavigator('Ordonnance', 'ordonnance', setSelectedIndex,
                      pageIndex: 2, active: selectedIndex == 2),
                  LeftBarNavigator('Settings', 'settings', setSelectedIndex,
                      pageIndex: 3, active: selectedIndex == 3),
                ],
              ),
            )
          ],
        ));
  }
}
