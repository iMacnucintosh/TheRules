import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interactive_slider/interactive_slider.dart';
import 'package:therules/src/providers/players_provider.dart';
import 'package:therules/src/screens/game.dart';
import 'package:therules/src/screens/settings.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset("assets/images/TheRulesWallpaper.png", fit: BoxFit.cover)),
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
                    width: 380,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.grey[800]),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: Text("Seleccione número de jugadores", style: TextStyle(fontSize: 16, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 15),
                        InteractiveSlider(
                          startIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 35,
                            shadows: const [Shadow(color: Colors.black, blurRadius: 4)],
                          ),
                          centerIcon: Text(
                            ref.watch(playersProvider).toString(),
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          endIcon: Icon(
                            Icons.group,
                            color: Colors.white,
                            size: 35,
                            shadows: const [Shadow(color: Colors.black, blurRadius: 4)],
                          ),
                          min: 1,
                          max: 20,
                          unfocusedHeight: 60,
                          focusedHeight: 63,
                          unfocusedOpacity: 1,
                          backgroundColor: Colors.grey[800],
                          foregroundColor: Theme.of(context).colorScheme.primaryContainer,
                          onChanged: (value) => ref.read(playersProvider.notifier).setPlayers(value),
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
                    pageBuilder: (context, animation, secondaryAnimation) => const Settings(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                      return SlideTransition(position: animation.drive(tween), child: child);
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

                      return SlideTransition(position: animation.drive(tween), child: child);
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
