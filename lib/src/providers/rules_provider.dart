import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:therules/src/components/rules_children/color_cloths.dart';
import 'package:therules/src/components/rules_children/drink_addicted.dart';
import 'package:therules/src/components/rules_children/russian_roulette.dart';
import 'package:therules/src/models/rule.dart';
import 'package:therules/src/providers/current_game_provider.dart';
import 'package:therules/src/providers/shared_preferences_provider.dart';

class RulesNotifier extends StateNotifier<List<Rule>> {
  RulesNotifier(this.ref) : super([]) {
    _initializeRules();
  }

  final Ref ref;
  Rule? previousRule;

  void _initializeRules() {
    final sharedPreferences = ref.watch(sharedPreferencesProvider);
    state = [
      Rule(
          id: "rule",
          imagePath: "assets/images/rules/1.png",
          name: "Rule!",
          description: "Rule of Rules: Pones una regla para toda la partida y bebe quién la incumpla. Las reglas tienen poder de eliminar otras.",
          enabled: sharedPreferences.getBool("rule") ?? true,
          onFinish: (context) async {
            void addNewGameRule(String newRule) {
              if (newRule.isNotEmpty) ref.read(gamesRulesProvider.notifier).add(newRule);
              Navigator.of(context).pop();
            }

            await showDialog(
              context: context,
              builder: (BuildContext context) {
                TextEditingController ruleController = TextEditingController();
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "¿Qué regla se ha decidido?",
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "La regla es ...",
                            ),
                            controller: ruleController,
                            onFieldSubmitted: (value) {
                              addNewGameRule(value);
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    addNewGameRule(ruleController.text);
                                  },
                                  child: const Text("Aceptar")),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
      Rule(
        id: "papo",
        imagePath: "assets/images/rules/2.png",
        name: "La virgen del Papo",
        description: "Mandas beber a quién tú quieras hasta un máximo de 10 tragos, puedes repartirlos. Todo en honor a nuestra Virgen del Papo",
        enabled: sharedPreferences.getBool("papo") ?? true,
      ),
      Rule(
        id: "lemon",
        imagePath: "assets/images/rules/3.png",
        name: "Un limón, medio limón!",
        description: "Un limón medio melón....",
        enabled: sharedPreferences.getBool("lemon") ?? true,
      ),
      Rule(
        id: "desert_island",
        imagePath: "assets/images/rules/4.png",
        name: "Isla Desierta",
        description: "Y tú, ¿Qué te llevarías a una isla desierta?",
        enabled: sharedPreferences.getBool("desert_island") ?? true,
      ),
      Rule(
        id: "chirla",
        imagePath: "assets/images/rules/5.png",
        name: "La Chirla",
        description:
            "Cada uno dice un número hasta llegar a 10, este en vez de 10 intercambia un número por la palabra que el quiera. El juego termina cuando se cambien todos los números.",
        enabled: sharedPreferences.getBool("chirla") ?? true,
      ),
      Rule(
        id: "maragato",
        imagePath: "assets/images/rules/6.png",
        name: "El tío Maragato",
        description: "En casa del Tío Maragato matarón un gato, ¿quién lo mato?",
        enabled: sharedPreferences.getBool("maragato") ?? true,
      ),
      Rule(
        id: "true_or_false",
        imagePath: "assets/images/rules/7.png",
        name: "¿Verdadero o Falso?",
        description: "Cuentas una historia y los demás tienen que adivinar si es verdad o mentira, beben los que fallen.",
        enabled: sharedPreferences.getBool("true_or_false") ?? false,
      ),
      Rule(
        id: "forbidden_word",
        imagePath: "assets/images/rules/8.png",
        name: "Palabra prohibida",
        description: "Prohíbe una palabra para que beba cualquiera que la diga durante toda la partida.",
        enabled: sharedPreferences.getBool("forbidden_word") ?? true,
        onFinish: (context) async {
          void addNewWordRule(String word) {
            if (word.isNotEmpty) ref.read(gamesWordsProvider.notifier).add(word);
            Navigator.of(context).pop();
          }

          await showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController wordController = TextEditingController();
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "¿Qué palabra se ha prohibido?",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "No se puede decir ...",
                          ),
                          controller: wordController,
                          onFieldSubmitted: (value) {
                            addNewWordRule(value);
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  addNewWordRule(wordController.text);
                                },
                                child: const Text("Aceptar")),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      Rule(
        id: "drunk_men",
        imagePath: "assets/images/rules/9.png",
        name: "Hombres borrachos",
        description: "Beben todos aquellos que se precien de llamar hombres...",
        enabled: sharedPreferences.getBool("drunk_men") ?? true,
      ),
      Rule(
        id: "drunk_woman",
        imagePath: "assets/images/rules/10.png",
        name: "Mujeres borrachas",
        description: "Beben todas aquellas dignas se ser mujeres",
        enabled: sharedPreferences.getBool("drunk_woman") ?? true,
      ),
      Rule(
        id: "i_never",
        imagePath: "assets/images/rules/11.png",
        name: "Yo Nunca",
        description: "Yo nunca he... bebido!",
        enabled: sharedPreferences.getBool("i_never") ?? true,
      ),
      Rule(
        id: "hands_up",
        imagePath: "assets/images/rules/12.png",
        name: "Arriba la Mano!",
        description: "El último en subir la mano bebe",
        enabled: sharedPreferences.getBool("hands_up") ?? true,
      ),
      Rule(
        id: "clock",
        imagePath: "assets/images/rules/13.png",
        name: "Relojito",
        description: "Bebes un trago y los demás +1 por cada jugador anterior",
        enabled: sharedPreferences.getBool("clock") ?? false,
      ),
      Rule(
        id: "russian_roulette",
        imagePath: "assets/images/rules/14.png",
        name: "Ruleta Rusa",
        description: "Todos los jugadores tendrán una bala en el cargador, ¡Suerte!",
        enabled: sharedPreferences.getBool("russian_roulette") ?? true,
        child: const RussianRoulette(),
      ),
      Rule(
        id: "free_shot",
        imagePath: "assets/images/rules/15.png",
        name: "Chupito gratis",
        description: "Bebeté un chupito por lo bien que te lo estas pasando",
        enabled: sharedPreferences.getBool("free_shot") ?? false,
      ),
      Rule(
        id: "gm_manolo",
        imagePath: "assets/images/rules/16.png",
        name: "Buenos días Manolo",
        description:
            'Mira a quién quieras y dile: "Buenos días Manolo", y te contestará: "Buenos días Manolo", entonces tu dirás: "Buenos días a Manolo, manolo"',
        enabled: sharedPreferences.getBool("gm_manolo") ?? false,
      ),
      Rule(
        id: "rock_paper_scissors",
        imagePath: "assets/images/rules/17.png",
        name: "Piedra, Papel o Tijera",
        description: "(x3) Piedra papel o tijera con el de tu derecha, si coincidís bebéis los dos, el que pierda cada ronda bebe",
        enabled: sharedPreferences.getBool("rock_paper_scissors") ?? true,
      ),
      Rule(
        id: "peruvian_boat",
        imagePath: "assets/images/rules/18.png",
        name: "Barquito Peruano",
        description:
            '"Un barquito peruano viene cargado de... (colores)", y el resto tienen que ir diciendo uno a uno un color, hasta que uno falle o repita.',
        enabled: sharedPreferences.getBool("peruvian_boat") ?? false,
      ),
      Rule(
        id: "try_or_10_drinks",
        imagePath: "assets/images/rules/19.png",
        name: "Prueba o 10 tragos",
        description:
            "El primero que levante la mano tiene el poder de mandarte realizar una prueba, a no ser que tu bebas 10 tragos antes de que te diga la regla.",
        enabled: sharedPreferences.getBool("try_or_10_drinks") ?? false,
      ),
      Rule(
        id: "valkyrie",
        imagePath: "assets/images/rules/20.png",
        name: "Valkiria",
        description:
            "Al jugador que le toque la Valkiria se convierte en Valkiria hasta que alguno de los demás consiga matarlo. El jugador irá guiñando el ojo 2 veces por ronda y esas personas irán muriendo. Si consigue matar 6 jugadores se repartirán 50 tragos entre todos los jugadores a excepción de la Valkiria. Para matar a la Valkiria los jugadores tendrán que adivinar al menos una persona que ha matado la Valkiria, si lo hace repartirá 20 tragos, en caso de fallar beberá 5. Mientras la Valkiria siga viva no podrá haber otra, pero si en tu ronda te toca esta regla podrás adivinar una persona muerta, entonces tu te convertirás en la nueva Valkiria. Las personas que hayan muerto podrán repartir 2 tragos si la Valkiria gana la partida y quedan extentos del reparto de los 50 tragos.",
        enabled: sharedPreferences.getBool("valkyrie") ?? false,
      ),
      Rule(
        id: "medusa",
        imagePath: "assets/images/rules/21.png",
        name: "Medusa",
        description:
            'Los otros jugadores tienen que cerrar los ojos y mirar al suelo durante 3 segundos, después levantarán la cabeza y los abrirán, si coinciden mirándose con otro, tendrán que decir rápidamente "MEDUSA!", el último en decirlo bebe.',
        enabled: sharedPreferences.getBool("medusa") ?? false,
      ),
      Rule(
        id: "f_k_m",
        imagePath: "assets/images/rules/22.png",
        name: "Follar, Matar o Casar",
        description: "Elije una persona para cada cosa.\nFollar = 1 trago.\nMatar = 10 tragos.\nCasar = Si tu bebes, el también durante una ronda.",
        enabled: sharedPreferences.getBool("f_k_m") ?? true,
      ),
      Rule(
        id: "drink_addicted",
        imagePath: "assets/images/rules/23.png",
        name: "Adictos a una Bebida",
        description: "Beben todos aquellos que estén bebiendo una bebida especifica.",
        enabled: sharedPreferences.getBool("drink_addicted") ?? true,
        child: const DrinkAddicted(),
      ),
      Rule(
        id: "pim_pam_pum",
        imagePath: "assets/images/rules/24.png",
        name: "PIM, PAM, PUM!",
        description: "Dices tu...",
        enabled: sharedPreferences.getBool("pim_pam_pum") ?? true,
      ),
      Rule(
        id: "linked_story",
        imagePath: "assets/images/rules/25.png",
        name: "Historia Enlazada",
        description:
            "Empiezas diciendo una frase que comenzará una historia, el siguiente jugador tendrá que darla vida diciendo otra frase. El último jugador, (el de tu izquierda), está obligado a terminar la historia.",
        enabled: sharedPreferences.getBool("linked_story") ?? false,
      ),
      Rule(
        id: "ten",
        imagePath: "assets/images/rules/26.png",
        name: "El 10!",
        description:
            "Todos cuentan hasta 10 en voz alta. Si dos o más coinciden en el mismo número beberán tantos tragos como el número en el que coincidan. No puedes decir dos números seguidos o beberás!. Si alguien llega a 10, todos aquellos que no hayan dicho ninguno beberán 10 tragos.",
        enabled: sharedPreferences.getBool("ten") ?? true,
      ),
      Rule(
        id: "colored_clothes",
        imagePath: "assets/images/rules/27.png",
        name: "Ropajes de Color",
        description: "Bebe quién lleve algo del color indicado.",
        enabled: sharedPreferences.getBool("colored_clothes") ?? true,
        child: const ColorCloths(),
      ),
      Rule(
        id: "crazy_horse",
        imagePath: "assets/images/rules/28.png",
        name: "El caballo loco",
        description: "El próximo jugador no tira, pero puede hacerlo mandándote beber a costa de beber él mismo el doble de tragos.",
        enabled: sharedPreferences.getBool("crazy_horse") ?? false,
      ),
      Rule(
        id: "chained_syllable",
        imagePath: "assets/images/rules/29.png",
        name: "Sílaba Encadenada",
        description: "Dices una palabra y el siguiente otra que empiece como terminaba la tuya.",
        enabled: sharedPreferences.getBool("chained_syllable") ?? false,
      ),
      Rule(
        id: "half_a_proverb",
        imagePath: "assets/images/rules/30.png",
        name: "Medio refrán",
        description: "Dices medio refrán y el siguiente tiene que decir el resto del refrán. Si no lo sabe continua al siguiente, hasta que uno acierte. Los que no acierten beberán.",
        enabled: sharedPreferences.getBool("half_a_proverb") ?? true,
      ),
    ];
  }

  void toggleRule(int index) {
    final sharedPreferences = ref.watch(sharedPreferencesProvider);
    final updatedRules = List<Rule>.from(state);
    final Rule updatedRule = updatedRules[index];
    updatedRule.enabled = !updatedRule.enabled;
    sharedPreferences.setBool(updatedRule.id, updatedRule.enabled);
    state = updatedRules;
  }

  List<Rule> getEnabledRules() {
    return state.where((element) => element.enabled).toList();
  }

  Rule? getRandomRule() {
    List<Rule> enabledRules = getEnabledRules();
    if (enabledRules.length > 1) {
      Rule rule = enabledRules[Random().nextInt(enabledRules.length)];
      while (previousRule == rule) {
        rule = enabledRules[Random().nextInt(enabledRules.length)];
      }
      previousRule = rule;
      return rule;
    } else {
      return null;
    }
  }
}

final rulesProvider = StateNotifierProvider<RulesNotifier, List<Rule>>((ref) {
  return RulesNotifier(ref);
});
