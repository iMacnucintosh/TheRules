import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:therules/src/providers/players_provider.dart';
import 'package:therules/src/screens/game.dart';
import 'package:therules/src/screens/rules.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/TheRulesWallpaper.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Text(
              "TheRules",
              textAlign: TextAlign.center,
              style: GoogleFonts.teko(fontSize: 62, color: Colors.white),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 200),
                  child: SizedBox(
                    width: 280,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton.filled(
                          onPressed: () => ref.read(playersProvider.notifier).removePlayer(),
                          icon: const Icon(
                            Icons.remove_outlined,
                            size: 35,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey[800],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(28, 16, 28, 16),
                            child: Text(
                              ref.watch(playersProvider).toString(),
                              style: const TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ),
                        IconButton.filled(
                          onPressed: () => ref.read(playersProvider.notifier).addPlayer(),
                          icon: const Icon(
                            Icons.add_outlined,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const Rules(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              tooltip: "Seleccionar reglas",
              child: const Icon(Icons.checklist),
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const Game(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              tooltip: "Empezar partida",
              child: const Icon(Icons.nightlife_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
