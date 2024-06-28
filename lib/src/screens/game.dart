import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:therules/src/models/rule.dart';
import 'package:therules/src/providers/current_game_provider.dart';
import 'package:therules/src/providers/rules_provider.dart';
import 'package:therules/src/screens/settings.dart';

class Game extends ConsumerStatefulWidget {
  const Game({super.key});

  @override
  GameState createState() => GameState();
}

class GameState extends ConsumerState<Game> {
  late Rule currentRule;

  @override
  void initState() {
    currentRule = ref.read(rulesProvider.notifier).getRandomRule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FilledButton(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(
              Theme.of(context).colorScheme.primary,
            ),
          ),
          child: const Text("INFO PARTIDA"),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: StatefulBuilder(builder: (context, setState) {
                      final gameRulesProvider = ref.watch(gamesRulesProvider);
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Reglas activas",
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                              ],
                            ),
                            const Divider(),
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: gameRulesProvider.length,
                              itemBuilder: (context, index) => Card(
                                child: ListTile(
                                  title: Text(
                                    gameRulesProvider[index],
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                  trailing: IconButton(
                                    tooltip: "Eliminar regla",
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      ref.read(gamesRulesProvider.notifier).removeGameRule(gameRulesProvider[index]);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Palabras prohibidas",
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Divider(),
                            // ListView.builder(
                            //   padding: EdgeInsets.zero,
                            //   shrinkWrap: true,
                            //   itemCount: gameRulesProvider.length,
                            //   itemBuilder: (context, index) => Card(
                            //     child: ListTile(
                            //       title: Text(
                            //         gameRulesProvider[index],
                            //         style: Theme.of(context).textTheme.titleSmall,
                            //       ),
                            //       trailing: IconButton(
                            //         tooltip: "Eliminar regla",
                            //         icon: const Icon(
                            //           Icons.delete,
                            //           color: Colors.red,
                            //         ),
                            //         onPressed: () {},
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    }),
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
                    pageBuilder: (context, animation, secondaryAnimation) => const Settings(),
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
                  child: FilledButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.asset(currentRule.imagePath),
                                    const SizedBox(height: 20),
                                    Text(
                                      currentRule.name,
                                      style: Theme.of(context).textTheme.headlineSmall,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      currentRule.description,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentRule.name,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Icon(Icons.info_outline),
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
                      nextRule();
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
                  child: FilledButton(
                    onPressed: () {
                      nextRule();
                    },
                    child: const SizedBox(
                      height: 150,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.casino_outlined, size: 40),
                            Text(
                              "TIRAR",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.casino_outlined, size: 40),
                          ],
                        ),
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

  void nextRule() async {
    if (currentRule.onFinish != null) await currentRule.onFinish!(context);
    setState(() {
      currentRule = ref.read(rulesProvider.notifier).getRandomRule();
    });
  }
}
