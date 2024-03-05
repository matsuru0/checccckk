import 'package:flutter/material.dart';
import 'package:table_prototype/core/common/table_button.dart';
import 'package:table_prototype/theme/pallete.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.txt,
    required this.onTap,
  });
  final String txt;

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          TableButton(
              onTap: () {
                onTap();
              },
              icon: Icons.arrow_back),
          const SizedBox(
            width: 12,
          ),
          Text(txt,
              style: const TextStyle(
                  color: Pallete.headersColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 19))
        ]),
        const SizedBox(
          height: 35,
        ),
        const Divider(
          height: 1,
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: Pallete.dividerColor,
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
