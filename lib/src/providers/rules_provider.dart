import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:therules/src/models/rule.dart';
import 'package:therules/src/providers/current_game_provider.dart';

class RulesNotifier extends StateNotifier<List<Rule>> {
  RulesNotifier(this.ref) : super([]) {
    _initializeRules();
  }

  final Ref ref;

  void _initializeRules() {
    state = [
      Rule(
          imagePath: "assets/images/rules/1.png",
          name: "Rule!",
          description: "Rule of Rules: Pones una regla para toda la partida y bebe quién la incumpla. Las reglas tienen poder de eliminar otras.",
          enabled: true,
          onFinish: (context) {
            showDialog(
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
                            "¿Que regla se ha decidido?",
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "La regla es...",
                            ),
                            controller: ruleController,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    final rulesNotifier = ref.read(rulesProvider.notifier);
                                    rulesNotifier.addGameRule(ruleController.text);
                                    Navigator.of(context).pop(); // Close the dialog after adding the rule
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
        imagePath: "assets/images/rules/2.png",
        name: "La virgen del Papo",
        description: "Mandas beber a quién tú quieras hasta un máximo de 10 tragos, puedes repartirlos. Todo en honor a nuestra Virgen del Papo",
        enabled: true,
      ),
      Rule(
        imagePath: "assets/images/rules/3.png",
        name: "Un limón, medio limón!",
        description: "Un limón medio melón....",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/4.png",
        name: "Isla Desierta",
        description: "Y tú, ¿Qué te llevarías a una isla desierta?",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/5.png",
        name: "La Chirla",
        description:
            "Cada uno dice un número hasta llegar a 10, este en vez de 10 intercambia un número por la palabra que el quiera. El juego termina cuando se cambien todos los números.",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/6.png",
        name: "El tío Maragato",
        description: "En casa del Tío Maragato matarón un gato, ¿quién lo mato?",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/7.png",
        name: "¿Verdadero o Falso?",
        description: "Cuentas una historia y los demás tienen que adivinar si es verdad o mentira, beben los que fallen.",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/8.png",
        name: "Palabra prohibida",
        description: "Prohíbe una palabra para que beba cualquiera que la diga durante toda la partida.",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/9.png",
        name: "Hombres borrachos",
        description: "Beben todos aquellos que se precien de llamar hombres...",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/10.png",
        name: "Mujeres borrachas",
        description: "Beben todas aquellas dignas se ser mujeres",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/11.png",
        name: "Yo Nunca",
        description: "Yo nunca he... bebido!",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/12.png",
        name: "Arriba la Mano!",
        description: "El último en subir la mano bebe",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/13.png",
        name: "Relojito",
        description: "Bebes un trago y los demás +1 por cada jugador anterior",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/14.png",
        name: "Ruleta Rusa",
        description: "Todos los jugadores tendrán una bala en el cargador, ¡Suerte!",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/15.png",
        name: "Chupito gratis",
        description: "Bebeté un chupito por lo bien que te lo estas pasando",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/16.png",
        name: "Buenos días Manolo",
        description:
            'Mira a quién quieras y dile: "Buenos días Manolo", y te contestará: "Buenos días Manolo", entonces tu dirás: "Buenos días a Manolo, manolo"',
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/17.png",
        name: "Piedra, Papel o Tijera",
        description: "(x3) Piedra papel o tijera con el de tu derecha, si coincidís bebéis los dos, el que pierda cada ronda bebe",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/18.png",
        name: "Barquito Peruano",
        description:
            '"Un barquito peruano viene cargado de... (colores)", y el resto tienen que ir diciendo uno a uno un color, hasta que uno falle o repita.',
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/19.png",
        name: "Prueba o 10 tragos",
        description:
            "El primero que levante la mano tiene el poder de mandarte realizar una prueba, a no ser que tu bebas 10 tragos antes de que te diga la regla.",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/20.png",
        name: "Valkiria",
        description:
            "Al jugador que le toque la Valkiria se convierte en Valkiria hasta que alguno de los demás consiga matarlo. El jugador irá guiñando el ojo 2 veces por ronda y esas personas irán muriendo. Si consigue matar 6 jugadores se repartirán 50 tragos entre todos los jugadores a excepción de la Valkiria. Para matar a la Valkiria los jugadores tendrán que adivinar al menos una persona que ha matado la Valkiria, si lo hace repartirá 20 tragos, en caso de fallar beberá 5. Mientras la Valkiria siga viva no podrá haber otra, pero si en tu ronda te toca esta regla podrás adivinar una persona muerta, entonces tu te convertirás en la nueva Valkiria. Las personas que hayan muerto podrán repartir 2 tragos si la Valkiria gana la partida y quedan extentos del reparto de los 50 tragos.",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/21.png",
        name: "Medusa",
        description:
            'Los otros jugadores tienen que cerrar los ojos y mirar al suelo durante 3 segundos, después levantarán la cabeza y los abrirán, si coinciden mirándose con otro, tendrán que decir rápidamente "MEDUSA!", el último en decirlo bebe.',
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/22.png",
        name: "Follar, Matar o Casar",
        description: "Elije una persona para cada cosa.\nFollar = 1 trago.\nMatar = 10 tragos.\nCasar = Si tu bebes, el también durante una ronda.",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/23.png",
        name: "Adictos a una Bebida",
        description: "Beben todos aquellos que estén bebiendo una bebida especifica.",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/24.png",
        name: "PIM, PAM, PUM!",
        description: "Dices tu...",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/25.png",
        name: "Historia Enlazada",
        description:
            "Empiezas diciendo una frase que comenzará una historia, el siguiente jugador tendrá que darla vida diciendo otra frase. El último jugador, (el de tu izquierda), está obligado a terminar la historia.",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/26.png",
        name: "El 10!",
        description:
            "Todos cuentan hasta 10 en voz alta. Si dos o más coinciden en el mismo número beberán tantos tragos como el número en el que coincidan. No puedes decir dos números seguidos o beberás!. Si alguien llega a 10, todos aquellos que no hayan dicho ninguno beberán 10 tragos.",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/27.png",
        name: "Ropajes de Color",
        description: "Bebe quién lleve algo del color indicado.",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/28.png",
        name: "El caballo loco",
        description: "El próximo jugador no tira, pero puede hacerlo mandándote beber a costa de beber él mismo el doble de tragos.",
        enabled: false,
      ),
      Rule(
        imagePath: "assets/images/rules/29.png",
        name: "Sílaba Encadenada",
        description: "Dices una palabra y el siguiente otra que empiece como terminaba la tuya.",
        enabled: false,
      ),
    ];
  }

  void toggleRule(int index) {
    final updatedRules = List<Rule>.from(state);
    updatedRules[index].enabled = !updatedRules[index].enabled;
    state = updatedRules;
  }

  void addGameRule(String ruleDescription) {
    ref.read(gamesRulesProvider.notifier).addGameRule(ruleDescription);
  }

  List<Rule> getEnabledRules() {
    return state.where((element) => element.enabled).toList();
  }

  Rule getRandomRule() {
    List<Rule> enabledRules = getEnabledRules();
    return enabledRules[Random().nextInt(enabledRules.length)];
  }
}

final rulesProvider = StateNotifierProvider<RulesNotifier, List<Rule>>((ref) {
  return RulesNotifier(ref);
});
