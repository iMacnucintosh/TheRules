import 'dart:math';
import 'package:flutter/material.dart';

class RussianRoulette extends StatefulWidget {
  const RussianRoulette({super.key});

  @override
  State<RussianRoulette> createState() => _RussianRouletteState();
}

class _RussianRouletteState extends State<RussianRoulette> {
  bool killed = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !killed
        ? IconButton(
            onPressed: () async {
              int shoot = Random().nextInt(2);
              if (shoot == 0) {
                killed = true;
                setState(() {});
                await Future.delayed(const Duration(seconds: 1));
                killed = false;

                if (mounted) setState(() {});
              }
            },
            icon: Image.asset(
              "assets/images/shoot.png",
              width: 100,
            ))
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.red,
            ),
            width: 100,
            height: 100,
            child: Center(
                child: Text(
              "¡¡¡ BEBES !!!",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white),
            )),
          );
  }
}
