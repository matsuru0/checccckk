import 'package:flutter/material.dart';
import 'package:table_prototype/theme/pallete.dart';

class CallToActionButton extends StatelessWidget {
  const CallToActionButton(this.txt, this.icon, this.onPress, {super.key});
  final String txt;
  final IconData icon;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: SizedBox(
        //height: double.infinity,
        child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(left: 20, right: 20),
            primary: Pallete.lightBlueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 21),
              const SizedBox(width: 8),
              Text(
                txt,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
