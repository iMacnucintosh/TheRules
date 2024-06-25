import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:therules/src/models/rule.dart';
import 'package:therules/src/providers/rules_provider.dart';
import 'package:therules/src/screens/rules.dart';

class Game extends ConsumerWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Rule currentRule = ref.read(rulesProvider.notifier).getRandomRule();
    return Scaffold(
      appBar: AppBar(
        title: FilledButton(
          child: const Text("INFO PARTIDA"),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const Dialog(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[Text("hola")],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              tooltip: "Seleccionar reglas",
              icon: const Icon(
                Icons.checklist,
              ),
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
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
          double size = width < height ? width : height;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentRule.name,
                            style: TextStyle(fontSize: 30, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: size - 60,
                    minHeight: size - 60,
                    maxWidth: size - 60,
                    maxHeight: size - 60,
                  ),
                  child: FilledButton(
                    onPressed: () {
                      ref.read(rulesProvider.notifier).getRandomRule();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        currentRule.imagePath,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.casino_outlined, size: 40, color: Colors.grey[700]),
                          Text(
                            "TIRAR",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          Icon(Icons.casino_outlined, size: 40, color: Colors.grey[700]),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
