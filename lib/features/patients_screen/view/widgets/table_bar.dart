import 'package:flutter/material.dart';
import 'package:table_prototype/features/patients_screen/controller/clients_controller.dart';
import 'package:table_prototype/features/patients_screen/view/constants.dart';
import 'package:table_prototype/theme/pallete.dart';

class Table_bar extends StatelessWidget {
  // Table topbar
  const Table_bar(
    this.notifier, {
    super.key,
  });
  final ClientNotifier notifier;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: const BoxDecoration(
          color: Pallete.lightBlueColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        padding: const EdgeInsets.only(left: 35, right: 20),
        height: 50,
        child: Row(
          children: [
            /*  bar_text('Patients', 'familyName'),
              SizedBox(
                width: spacing_between_bar_info,
              ),
              bar_text('Age', 'age'),
              SizedBox(
                width: spacing_between_bar_info,
              ),
              bar_text('Ville', 'ville'),
              SizedBox(
                width: spacing_between_bar_info,
              ),
              bar_text('Phone number', 'phone'),
              SizedBox(
                width: spacing_between_bar_info,
              ),
              bar_text('Derniére visite', 'lastVisit'),
              SizedBox(
                width: spacing_between_bar_info,
              ),
              bar_text('Prochaine visite', ''),*/
            bar_text('Patients', 'familyName'),
            constraints.maxWidth > 900
                ? bar_text('Age', 'age')
                : const SizedBox(),
            constraints.maxWidth > 900
                ? bar_text('Ville', 'ville')
                : const SizedBox(),
            bar_text('Phone number', 'phone'),
            bar_text('Derniére visite', 'lastVisit'),
            constraints.maxWidth > 600
                ? bar_text('Prochaine visite', '')
                : const SizedBox(),
            Container(
              width: 50,
            )
          ],
        ),
      );
    });
  }

  Expanded bar_text(String txt, String sort) => Expanded(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              notifier.clientSort(sort);
            },
            child: Row(
              children: [
                Text(txt,
                    style: const TextStyle(color: Colors.white, fontSize: 13)),
                const SizedBox(width: 3),
                Image.asset(
                  'assets/sort.png',
                  height: 12,
                  width: 12,
                  filterQuality: FilterQuality.medium,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
      );
}
