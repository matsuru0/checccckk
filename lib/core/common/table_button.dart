import 'package:flutter/material.dart';

class TableButton extends StatelessWidget {
  const TableButton({super.key, required this.onTap, required this.icon});

  final VoidCallback onTap;

  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(onTap: onTap, child: Icon(icon)));
  }
}
