import 'package:copilet/models/chartStatus.dart';
import 'package:flutter/material.dart';

// painters/status_background_painter.dart
// import 'package:flutter/material.dart';
// import '../models/chart_status.dart';

class StatusBackgroundPainter extends CustomPainter {
  final List<ChartStatus> statusList;
  final double minY;
  final double maxY;

  // padding های فضای نمودار (مربوط به FlTitlesData)
  final double leftPadding;
  final double rightPadding;
  final double topPadding;
  final double bottomPadding;

  StatusBackgroundPainter({
    required this.statusList,
    required this.minY,
    required this.maxY,
    this.leftPadding = 40,
    this.rightPadding = 10,
    this.topPadding = 10,
    this.bottomPadding = 30,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    final chartWidth = size.width - leftPadding - rightPadding;
    final chartHeight = size.height - topPadding - bottomPadding;

    for (var status in statusList) {
      final top = topPadding + chartHeight * (1 - (status.endY - minY) / (maxY - minY));
      final bottom = topPadding + chartHeight * (1 - (status.startY - minY) / (maxY - minY));

      paint.color = status.color.withOpacity(0.2);
      canvas.drawRect(
        Rect.fromLTRB(leftPadding, top, leftPadding + chartWidth, bottom),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
