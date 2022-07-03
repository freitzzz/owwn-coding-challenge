import 'package:owwn_coding_challenge/presentation/presentation.dart';

// inspired from: https://stackoverflow.com/a/55993380
class DashLinePainter extends CustomPainter {
  final Color color;

  final double strokeWidth;

  final double dashWidth;

  const DashLinePainter({
    this.color = const Color(0x38AFB2CB),
    this.strokeWidth = 2.0,
    this.dashWidth = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color;

    var x = 0.0;

    while (x < size.width) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + dashWidth, 0),
        paint,
      );

      x += dashWidth * 2;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
