import 'dart:math';

import 'package:flutter/material.dart';

class DrinkAddicted extends StatefulWidget {
  const DrinkAddicted({super.key});

  @override
  State<DrinkAddicted> createState() => _DrinkAddictedState();
}

class _DrinkAddictedState extends State<DrinkAddicted> {
  final List<String> drinks = ["Larios", "Brugal", "Barceló", "Whisky", "Cerveza", "Calimocho", "Vodka"];
  late String drink;
  @override
  void initState() {
    drink = drinks[Random().nextInt(drinks.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Beben los adictos a: "),
        Text(
          drink,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
