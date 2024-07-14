import 'package:flutter/material.dart';

// panting the rectangle on camera 
class CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final overlayPaint = Paint()
      ..color = Colors.black12
      ..style = PaintingStyle.fill;

    double cornerLength = 30.0;
    double rectWidth = size.width / 1.3;
    double rectHeight = size.height / 2;

    // Draw the dimmed background
    Path backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRect(Rect.fromLTWH((size.width - rectWidth) / 2,
          (size.height - rectHeight) / 2, rectWidth, rectHeight))
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(backgroundPath, overlayPaint);

    // Calculate the rectangle's coordinates
    double left = (size.width - rectWidth) / 2;
    double top = (size.height - rectHeight) / 2;
    double right = left + rectWidth;
    double bottom = top + rectHeight;

    // Top left corner
    canvas.drawLine(Offset(left, top), Offset(left + cornerLength, top), paint);
    canvas.drawLine(Offset(left, top), Offset(left, top + cornerLength), paint);

    // Top right corner
    canvas.drawLine(
        Offset(right, top), Offset(right - cornerLength, top), paint);
    canvas.drawLine(
        Offset(right, top), Offset(right, top + cornerLength), paint);

    // Bottom left corner
    canvas.drawLine(
        Offset(left, bottom), Offset(left, bottom - cornerLength), paint);
    canvas.drawLine(
        Offset(left, bottom), Offset(left + cornerLength, bottom), paint);

    // Bottom right corner
    canvas.drawLine(
        Offset(right, bottom), Offset(right, bottom - cornerLength), paint);
    canvas.drawLine(
        Offset(right, bottom), Offset(right - cornerLength, bottom), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
