import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:therules/src/providers/players_provider.dart';

class RussianRoulette extends ConsumerStatefulWidget {
  const RussianRoulette({super.key});

  @override
  RussianRouletteState createState() => RussianRouletteState();
}

class RussianRouletteState extends ConsumerState<RussianRoulette> {
  bool killed = false;
  late int players;
  int currentPlayer = 0;
  bool finish = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    players = ref.watch(playersProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !finish
          ? !killed
              ? Row(
                  children: [
                    Expanded(
                      child: IconButton(
                          onPressed: () async {
                            int shoot = Random().nextInt(2);
                            currentPlayer += 1;
                            if (shoot <= 0) {
                              killed = true;
                              setState(() {});

                              await Future.delayed(const Duration(seconds: 1));
                              killed = false;

                              if (mounted) setState(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Jugador $currentPlayer libras"),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            }
                            if (currentPlayer >= players) {
                              finish = true;
                              setState(() {});
                            }
                          },
                          icon: Image.asset(
                            "assets/images/shoot.png",
                            width: 100,
                          )),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.red,
                        ),
                        height: 100,
                        child: Center(
                            child: Text(
                          "¡¡¡ Jugador $currentPlayer BEBES !!!",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                )
          : const Center(
              child: Text(
                "Ronda terminada",
                style: TextStyle(fontSize: 20),
              ),
            ),
    );
  }
}
