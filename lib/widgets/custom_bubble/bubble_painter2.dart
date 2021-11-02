import 'package:flutter/material.dart';

class BubblePainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bubbleSize = Size(size.width, size.height);
    final sideX = bubbleSize.width / 8;
    final sideY = bubbleSize.height / 2;

    final bubblePath = Path()
      ..moveTo(sideX * 6, 0)
      ..arcTo(Offset(0, 0) & Size(sideX * 2, sideY * 2), -1.5, -3, false)
      ..lineTo(sideX * 6, bubbleSize.height)
      ..arcTo(Offset(sideX * 6, 0) & Size(sideX * 2, sideY * 2), 1.5, -3, false)
      ..lineTo(sideX * 6, 0);

    final tailPath = Path()
      ..moveTo(bubbleSize.width / 2 - 20, bubbleSize.height - 10)
      ..lineTo(bubbleSize.width / 2, bubbleSize.height + 20)
      ..lineTo(bubbleSize.width / 2 + 20, bubbleSize.height - 10);

    final inPath = Path()
      ..moveTo(bubbleSize.width / 2 - 14, bubbleSize.height - 5)
      ..lineTo(bubbleSize.width / 2, bubbleSize.height + 15)
      ..lineTo(bubbleSize.width / 2 + 14, bubbleSize.height - 5);

    final paint = Paint()
      ..color = Color(0xFFD7C1B9)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final paint2 = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    canvas.drawPath(bubblePath, paint);
    canvas.drawPath(tailPath, paint);
    canvas.drawPath(inPath, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
