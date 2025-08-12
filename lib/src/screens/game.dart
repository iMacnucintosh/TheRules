import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:therules/src/models/rule.dart';
import 'package:therules/src/providers/current_game_provider.dart';
import 'package:therules/src/providers/custom_rules_provider.dart';
import 'package:therules/src/providers/rules_provider.dart';
import 'package:therules/src/providers/theme_provider.dart';
import 'package:therules/src/screens/settings.dart';

class Game extends ConsumerStatefulWidget {
  const Game({super.key});

  @override
  GameState createState() => GameState();
}

class GameState extends ConsumerState<Game> {
  late Rule? currentRule;
  late List<String> _gameRules;
  late List<String> _gameWords;
  String? _currentRuleImageBase64;

  bool enaughtRules = true;

  @override
  void initState() {
    super.initState();
    currentRule = ref.read(rulesProvider.notifier).getRandomRule();
    _gameRules = ref.read(gamesRulesProvider);
    _gameWords = ref.read(gamesWordsProvider);
    _updateCurrentRuleImage();
  }

  void _updateCurrentRuleImage() {
    if (currentRule != null) {
      // Verificar si es una regla personalizada
      final customRules = ref.read(customRulesProvider);
      final customRule = customRules.where((rule) => rule.id == currentRule!.id).firstOrNull;

      if (customRule != null) {
        _currentRuleImageBase64 = customRule.imageBase64;
      } else {
        _currentRuleImageBase64 = null;
      }
    }
  }

  Widget _buildRuleImage() {
    if (_currentRuleImageBase64 != null) {
      // Regla personalizada
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.memory(base64Decode(_currentRuleImageBase64!), fit: BoxFit.contain),
        ),
      );
    } else {
      // Regla predefinida
      return Image.asset(currentRule!.imagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    enaughtRules = ref.read(rulesProvider.notifier).getEnabledRules().length > 1;

    return Scaffold(
      appBar: AppBar(
        title: FilledButton(
          style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary)),
          child: const Text("INFO PARTIDA"),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        _gameRules = ref.read(gamesRulesProvider);
                        _gameWords = ref.read(gamesWordsProvider);
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Reglas activas", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                              const Divider(),
                              _gameRules.isNotEmpty
                                  ? ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: _gameRules.length,
                                      itemBuilder: (context, index) => Card(
                                        child: ListTile(
                                          title: Text(_gameRules[index], style: Theme.of(context).textTheme.titleSmall),
                                          trailing: IconButton(
                                            tooltip: "Eliminar regla",
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              ref.read(gamesRulesProvider.notifier).remove(_gameRules[index]);
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  : ListTile(title: Text("Todavía no se ha añadido ninguna regla", style: Theme.of(context).textTheme.titleSmall)),
                              const SizedBox(height: 20),
                              Text("Palabras prohibidas", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
                              const Divider(),
                              _gameWords.isNotEmpty
                                  ? ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: _gameWords.length,
                                      itemBuilder: (context, index) => Card(
                                        child: ListTile(
                                          title: Text(_gameWords[index], style: Theme.of(context).textTheme.titleSmall),
                                          trailing: IconButton(
                                            tooltip: "Eliminar palabra",
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              ref.read(gamesWordsProvider.notifier).remove(_gameWords[index]);
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  : ListTile(
                                      title: Text("Todavía no se ha prohibido ninguna palabra", style: Theme.of(context).textTheme.titleSmall),
                                    ),
                            ],
                          ),
                        );
                      },
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
              icon: const Icon(Icons.checklist),
              onPressed: () async {
                await Navigator.push(
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
                nextRule();
              },
            ),
          ),
        ],
      ),
      body: enaughtRules && currentRule != null
          ? LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;
                double size = width < height ? width : height;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Título de la regla
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
                                        _buildRuleImage(),
                                        const SizedBox(height: 20),
                                        Text(currentRule!.name, style: Theme.of(context).textTheme.headlineSmall),
                                        const SizedBox(height: 20),
                                        Text(currentRule!.description, textAlign: TextAlign.justify),
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
                              Text(currentRule!.name, style: const TextStyle(fontSize: 25)),
                              const SizedBox(width: 15),
                              const Icon(Icons.info_outline),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Imagen central
                    ConstrainedBox(
                      constraints: BoxConstraints(minWidth: size - 60, minHeight: size - 60, maxWidth: size - 60, maxHeight: size - 60),
                      child: FilledButton(
                        onPressed: () {
                          nextRule();
                        },
                        child: Padding(padding: const EdgeInsets.all(10.0), child: _buildRuleImage()),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Botón de tirar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: currentRule!.child != null
                          ? Container(
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: ref.watch(accentColorProvider), width: 1.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: Row(children: [Expanded(child: currentRule!.child!)]),
                                ),
                              ),
                            )
                          : FilledButton(
                              onPressed: () {
                                nextRule();
                              },
                              child: const SizedBox(
                                height: 120,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(Icons.casino_outlined, size: 40),
                                    Text("TIRAR", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                                    Icon(Icons.casino_outlined, size: 40),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ],
                );
              },
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text("No seais maricones y activad más reglas", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
              ),
            ),
    );
  }

  void nextRule() async {
    if (currentRule != null) if (currentRule!.onFinish != null) await currentRule!.onFinish!(context);
    setState(() {
      currentRule = ref.read(rulesProvider.notifier).getRandomRule();
      _updateCurrentRuleImage();
    });
  }
}
