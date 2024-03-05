import 'package:flutter/material.dart';
import 'package:table_prototype/models/client_model.dart';

class MyPainter extends CustomPainter {

  const MyPainter(this.client);
  final ClientModel client;
  @override
  void paint(Canvas canvas, Size size) {
    // Your custom painting logic goes here
    // This is just a simple example
    Paint paint = Paint()..color = Colors.blue;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 50, paint);
    TextSpan ordonnanceSpan = TextSpan(
      text: 'YOOO WSUP BOYS',
      style: TextStyle(
        color: Color.fromARGB(255, 28, 28, 28),
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: 'Merriweather',
      ),
    );

    TextPainter ordonnanceSpanTp = TextPainter(
      text: ordonnanceSpan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      maxLines: 30, // Set a large number to allow multiple lines
      ellipsis: '...', // Optional: ellipsis if text exceeds the maximum width
    )..layout(maxWidth: size.width - 60);

    ordonnanceSpanTp.paint(
      canvas,
      Offset(20, (size.height) / 3),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
