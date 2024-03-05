import 'package:flutter/material.dart';
import 'package:table_prototype/theme/pallete.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton(this.icon, this.color,
      {this.txt = '', this.onTap, super.key});
  final IconData icon;
  final String txt;
  final VoidCallback? onTap;
  final color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onTap != null) {
          onTap!();
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(left: 20, right: 20),
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            if (txt != '')
              SizedBox(
                width: 5,
              ),
            if (txt != '')
              Text(txt,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter0',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.white,
                  ))
          ],
        ),
      ),
    );
  }
}
