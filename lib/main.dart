import 'package:flutter/material.dart';
import 'package:gif/home_page.dart';

void main() {
  runApp(const GIF());
}

class GIF extends StatelessWidget {
  const GIF({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent,
        ),
      ),
      home: HomePage(),
    );
  }
}
