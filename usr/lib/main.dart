import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fabrication Grill',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          surface: Colors.black,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const GrillScreen(),
      },
    );
  }
}

class GrillScreen extends StatelessWidget {
  const GrillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Space behind the grill
      body: SizedBox.expand(
        child: CustomPaint(
          painter: GrillPainter(),
        ),
      ),
    );
  }
}

class GrillPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

    const double spacing = 40.0;
    
    // Draw shadows and lines for the grill texture
    for (double i = 0; i < size.width + size.height; i += spacing) {
      // Diagonal lines /
      canvas.drawLine(
        Offset(i, 0),
        Offset(0, i),
        shadowPaint,
      );
      canvas.drawLine(
        Offset(i, 0),
        Offset(0, i),
        paint,
      );

      // Diagonal lines \
      canvas.drawLine(
        Offset(i - size.height, 0),
        Offset(i, size.height),
        shadowPaint,
      );
      canvas.drawLine(
        Offset(i - size.height, 0),
        Offset(i, size.height),
        paint,
      );
    }
    
    // Add vertical structural support bars
    final barPaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 12.0
      ..style = PaintingStyle.stroke;

    for (double i = spacing * 2; i < size.width; i += spacing * 4) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i, size.height),
        barPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
