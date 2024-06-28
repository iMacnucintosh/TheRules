import 'dart:math';

import 'package:flutter/material.dart';

class ColorCloths extends StatefulWidget {
  const ColorCloths({super.key});

  @override
  State<ColorCloths> createState() => _ColorClothsState();
}

class _ColorClothsState extends State<ColorCloths> {
  final List<Map<String, dynamic>> colors = [
    {"name": "Blanco", "color": Colors.white},
    {"name": "Negro", "color": Colors.black},
    {"name": "Rojo", "color": Colors.red},
    {"name": "Azul", "color": Colors.blue},
    {"name": "Marron", "color": Colors.brown},
    {"name": "Rosa", "color": Colors.pink},
    {"name": "Verde", "color": Colors.green},
    {"name": "Morado", "color": Colors.purple}
  ];

  late Map<String, dynamic> color;

  @override
  void initState() {
    color = colors[Random().nextInt(colors.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Beben los que lleven algo de:"),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: color["color"]!,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              color["name"]!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color["color"]! != Colors.white ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
